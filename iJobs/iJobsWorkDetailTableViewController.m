//
//  iJobsWorkDetailTableViewController.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/22.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkDetailTableViewController.h"
#import "IJobsWorkListItem.h"
#import "iJobsPhotoReportViewController.h"
#import "MapKit/MapKit.h"
#import "iJobsGoogleMapViewController.h"
#import "iJobsMapAnnotation.h"
#import "iJobsSignatureViewController.h"

@interface iJobsWorkDetailTableViewController()

- (NSMutableArray *)arrayWithWorkDetailTableItem:(IJobsWorkListItem *)workItem;
- (void)addSegmentedControll;
- (void)addMapView:(CGRect)frame;
- (void)actionsForSegment:(id)sender;
- (void)reporters;
- (void)photoReport;
- (void)clientSignature;
- (void)createMapPoint:(MKMapView *)mapView coordinateX:(double)coorX coordinateY:(double)coorY title:(NSString*)title subtitle:(NSString*)subtitle;
- (CLLocationCoordinate2D)addressLocation:(NSString *)chineseAddress;
- (void)addStreetView:(CGRect)frame;

@end

@implementation iJobsWorkDetailTableViewController

@synthesize workItem = _workItem;
@synthesize mapView = _mapView;
@synthesize webView = _webView;
@synthesize gMapViewController = _gMapViewController;
@synthesize signatureViewController = _signatureViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.tableViewStyle = UITableViewStyleGrouped;
      self.variableHeightRows = YES;
      self.title = @"工作說明";
    }
    return self;
}

- (id) initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
  self = [super init];
  if (self != nil) {
    self.workItem = [query objectForKey:kParameterWorkItem];
    TTDPRINT(@"URL: %@", URL);
    TTDPRINT(@"workItem :%@", self.workItem);
  }
  return self;
}


- (void)dealloc
{
  TT_RELEASE_SAFELY(_workItem);
  TT_RELEASE_SAFELY(_mapView);
  TT_RELEASE_SAFELY(_webView);
  TT_RELEASE_SAFELY(_gMapViewController);
  TT_RELEASE_SAFELY(_signatureViewController);
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{ 
  [super loadView];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回報" style:UIBarButtonItemStylePlain target:self action:@selector(reporters)];
  
  NSMutableArray *detailItems = [self arrayWithWorkDetailTableItem:self.workItem];
  self.dataSource = [TTListDataSource dataSourceWithItems:detailItems];
  self.view.tag = 0;
  
  CGRect frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - self.navigationController.navigationBar.height);
  [self addSegmentedControll];
  [self addMapView:frame];
  [self addStreetView:frame];
}

- (void)addMapView:(CGRect)frame {
  
  _mapView = [[MKMapView alloc] initWithFrame:frame];
  _mapView.delegate = self;
  _mapView.mapType = MKMapTypeStandard;
  _mapView.showsUserLocation = YES;
  _mapView.tag = 1; 
    
  //using - (void)createMapPoint:(MKMapView *)mapView coordinateX:(double)coorX coordinateY:(double)coorY title:(NSString*)title subtitle:(NSString*)subtitle;
  CLLocationCoordinate2D coordinate2D = [self addressLocation:_workItem.missionLocationAddress];
  [self createMapPoint:_mapView coordinateX:coordinate2D.latitude coordinateY:coordinate2D.longitude title:_workItem.missionTitle subtitle:_workItem.missionLocation];
  
  TTDPRINT(@"longitude: %f", coordinate2D.longitude);
  TTDPRINT(@"latitude: %f", coordinate2D.latitude);
  _workItem.longitude = [NSNumber numberWithDouble:coordinate2D.longitude];
  _workItem.latitude = [NSNumber numberWithDouble:coordinate2D.latitude];
  
  MKCoordinateRegion theRegion;
  //set region center
  CLLocationCoordinate2D theCenter;
  theCenter.latitude = coordinate2D.latitude;
  theCenter.longitude = coordinate2D.longitude;
  theRegion.center = theCenter;
  
  //set zoom level
  MKCoordinateSpan theSpan;
  theSpan.latitudeDelta = 0.009;
  theSpan.longitudeDelta = 0.009;
  theRegion.span = theSpan;
  
  _mapView.scrollEnabled = YES;
  _mapView.zoomEnabled = YES;
  
  [_mapView setRegion:theRegion];
  [_mapView regionThatFits:theRegion];
  
  [self.view addSubview:_mapView];
  [self.view sendSubviewToBack:_mapView];

  /*
  CGRect frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - self.navigationController.navigationBar.height);

  _gMapViewController = [[iJobsGoogleMapViewController alloc] initWithFrame:frame];
  
  _gMapViewController.mapView = [[MKMapView alloc] initWithFrame:frame];
  _gMapViewController.mapView.mapType = MKMapTypeStandard;
  _gMapViewController.mapView.showsUserLocation = YES;
  _gMapViewController.mapView.tag = 1;

  
  MKCoordinateRegion theRegion;
  //set region center
  CLLocationCoordinate2D theCenter;
  theCenter.latitude = 25.032054;
  theCenter.longitude = 121.529266;
  theRegion.center = theCenter;
  
  //set zoom level
  MKCoordinateSpan theSpan;
  theSpan.latitudeDelta = 0.009;
  theSpan.longitudeDelta = 0.009;
  theRegion.span = theSpan;
  
  _mapView.scrollEnabled = YES;
  _mapView.zoomEnabled = YES;
  
  [_mapView setRegion:theRegion];
  [_mapView regionThatFits:theRegion];

  
  [self.view addSubview:_gMapViewController.mapView];
  [self.view sendSubviewToBack:_gMapViewController.mapView];
 */
}

- (void)addStreetView:(CGRect)frame {
  _webView = [[UIWebView alloc] initWithFrame:frame];
  
  NSString *streetViewHTML = [NSString stringWithFormat:STREET_VIEW_HTML, [_workItem.latitude doubleValue], [_workItem.longitude doubleValue]];
  
  TTDPRINT(@"streetViewHTML: %@", streetViewHTML);
  
  [_webView loadHTMLString:streetViewHTML baseURL:[NSURL URLWithString:@"http://www.apple.com"]];
  [self.view addSubview:_webView];
  [self.view sendSubviewToBack:_webView];
}

- (void)addSegmentedControll {
  
  CGFloat positionY = self.view.bounds.size.height - self.navigationController.navigationBar.height;
  
  UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"工作說明", @"地圖", @"街景", nil]];
  [segmentControl addTarget:self action:@selector(actionsForSegment:) forControlEvents:UIControlEventValueChanged];
  segmentControl.frame = CGRectMake(0, 0, 308, 29);
  segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
  [segmentControl setSelectedSegmentIndex:0];
  
  UIToolbar *bottomBar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, positionY, 320, self.navigationController.navigationBar.height)] autorelease];  
  [bottomBar setItems:[NSArray arrayWithObject:[[UIBarButtonItem alloc] initWithCustomView:segmentControl]]];
  [self.view addSubview:bottomBar];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - private method
- (NSMutableArray *)arrayWithWorkDetailTableItem:(IJobsWorkListItem *)workItem {
  /*NSString *_missionTitle;
   NSString *_missionDetail;
   NSString *_missionLocationAddress;
   NSString *_missionDate;
   NSString *_workerName;
   NSString *_workerID;
   NSString *_customerName;
   NSString *_customerID;*/
  NSString *customerNameField = [NSString stringWithFormat:@"客戶名稱： %@", workItem.customerName];
  //NSString *workerNameField = [NSString stringWithFormat:@"工程師： %@", workItem.workerName];
  NSString *missionTitleField = [NSString stringWithFormat:@"任務名稱： %@", workItem.missionTitle];
  NSString *missionDetailField = [NSString stringWithFormat:@"任務說明： %@", workItem.missionDetail];
  NSString *missionLocationAddressField = [NSString stringWithFormat:@"任務地點： %@", workItem.missionLocationAddress];
  NSString *missionDateField = [NSString stringWithFormat:@"約定時間： %@", workItem.missionDate];
  
  return [NSMutableArray arrayWithObjects:
                                 [TTTableTextItem itemWithText: customerNameField],
                                 [TTTableTextItem itemWithText: missionTitleField],
                                 [TTTableTextItem itemWithText: missionLocationAddressField],
                                 [TTTableTextItem itemWithText: missionDateField],
                                 [TTTableTextItem itemWithText: missionDetailField],nil];

}

- (void)actionsForSegment:(id)sender {
  UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
  NSInteger selectedIndex = segmentedControl.selectedSegmentIndex;
  if (selectedIndex == 0) {
    [self.view sendSubviewToBack:_mapView];
    [self.view sendSubviewToBack:_webView];
  }else if(selectedIndex == 1) {
    [self.view bringSubviewToFront:_mapView];
  }else {
    //this is for street view.
    [self.view bringSubviewToFront:_webView];
  }
}

- (void)reporters {
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"回報方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"影像回報", @"客戶簽章", nil];
  
  [actionSheet showInView:self.view];
  TT_RELEASE_SAFELY(actionSheet);
}
- (void)photoReport {
  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
  }else {
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;  
  }

  [self presentModalViewController:picker animated:YES];  
  [picker release];
}

- (void)clientSignature {
  _signatureViewController = [[iJobsSignatureViewController alloc] init];
  _signatureViewController.delegate = self;
  [self presentModalViewController:_signatureViewController animated:YES];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  switch (buttonIndex) {
    case 0:
      [self photoReport];
      break;
    case 1:
      [self clientSignature];
      break;
    default:
      break;
  }
}

#pragma mark iJobsSignatureViewDelegate

- (void)clientDidFinishSignature:(UIImageView *)signatureImageView {
//  [self.workItem setClientSignatureImageView:signatureImageView];
// This method should be rewrite.
}

#pragma mark UIImagePickerController delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  //UIImage *selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
  UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
  iJobsPhotoReportViewController *reportViewController = [[iJobsPhotoReportViewController alloc] initWithImage:originalImage imagePicker:picker];
  [picker pushViewController:reportViewController animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissModalViewControllerAnimated:YES];
}

#pragma -
#pragma mark MapView Methods

- (void)createMapPoint:(MKMapView *)mapView coordinateX:(double)coorX coordinateY:(double)coorY title:(NSString*)title subtitle:(NSString*)subtitle {
  if (mapView != nil) {
    CLLocationCoordinate2D coordinate2D;
    iJobsMapAnnotation *mapAnnotation;
    
    if (coorX && coorY) {
      coordinate2D.latitude = coorX;
      coordinate2D.longitude = coorY;
      mapAnnotation = [[iJobsMapAnnotation alloc] initWithCoords:coordinate2D title:_workItem.missionTitle subtitle:_workItem.missionLocation];

      [mapView addAnnotation:mapAnnotation];
      
      
    }
  }
}

- (CLLocationCoordinate2D)addressLocation:(NSString *)chineseAddress {
  
  NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv", [chineseAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  TTDPRINT(@"addressLocation: %@", urlString);
//  NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
   
  NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] 
                                                      encoding:NSUTF8StringEncoding error:nil];
  
  NSArray *listItems = [locationString componentsSeparatedByString:@","];
  double latitude = 0.0;
  double longitude = 0.0;
  if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
    latitude = [[listItems objectAtIndex:2] doubleValue];
    longitude = [[listItems objectAtIndex:3] doubleValue]; 
  }
  else {
    //Show error  
  }
  
  CLLocationCoordinate2D location;
  location.latitude = latitude;
  location.longitude = longitude;
  
  return location;
  
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
	newAnnotation.pinColor = MKPinAnnotationColorGreen;
	newAnnotation.animatesDrop = YES; 
	//canShowCallout: to display the callout view by touch the pin
	newAnnotation.canShowCallout=YES;
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
	newAnnotation.rightCalloutAccessoryView=nil;	
  
	return newAnnotation;
}

@end
