//
//  iJobsWorkDetailTableViewController.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/22.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkDetailTableViewController.h"
#import "iJobsWorkListItem.h"
#import "iJobsPhotoReportViewController.h"
#import "MapKit/MapKit.h"
@interface iJobsWorkDetailTableViewController()

- (NSMutableArray *)arrayWithWorkDetailTableItem:(iJobsWorkListItem *)workItem;
- (void)addSegmentedControll;
- (void)addMapView;
- (void)actionsForSegment:(id)sender;
- (void)photoReport;
@end

@implementation iJobsWorkDetailTableViewController

@synthesize workItem = _workItem;
@synthesize mapView = _mapView;

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
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"影像回報" style:UIBarButtonItemStylePlain target:self action:@selector(photoReport)];
  
  NSMutableArray *detailItems = [self arrayWithWorkDetailTableItem:self.workItem];
  self.dataSource = [TTListDataSource dataSourceWithItems:detailItems];
  
  self.view.tag = 0;
  [self addSegmentedControll];
  [self addMapView];
}

- (void)addMapView {
  CGRect frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - self.navigationController.navigationBar.height);
  
  _mapView = [[MKMapView alloc] initWithFrame:frame];
  _mapView.mapType = MKMapTypeStandard;
  _mapView.showsUserLocation = YES;
  _mapView.tag = 1;

  [self.view addSubview:_mapView];
  [self.view sendSubviewToBack:_mapView];
}

- (void)addSegmentedControll {
  
  CGFloat positionY = self.view.bounds.size.height - self.navigationController.navigationBar.height;
  
  UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"工作說明", @"地圖", @"街景", nil]];
  [segmentControl addTarget:self action:@selector(actionsForSegment:) forControlEvents:UIControlEventValueChanged];
  segmentControl.frame = CGRectMake(0, 0, 308, 29);
  segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
  [segmentControl setSelectedSegmentIndex:0];
  
  UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, positionY, 320, self.navigationController.navigationBar.height)];  
  [bottomBar setItems:[NSArray arrayWithObject:[[UIBarButtonItem alloc] initWithCustomView:segmentControl]]];
  [self.view addSubview:bottomBar];
  //  UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithTitle:@"影像回報" style:UIBarButtonItemStyleBordered target:self action:nil];
  //  UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"地圖" style:UIBarButtonItemStyleBordered target:self action:nil];
  //  UIBarButtonItem *streetViewButton = [[UIBarButtonItem alloc] initWithTitle:@"街景" style:UIBarButtonItemStyleBordered target:self action:nil];
  //  
  //  UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
  //  
  //  NSMutableArray *buttons = [NSMutableArray arrayWithObjects:cameraButton, flexibleSpace, mapButton, flexibleSpace,streetViewButton, nil];
  

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - private method
- (NSMutableArray *)arrayWithWorkDetailTableItem:(iJobsWorkListItem *)workItem {
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
  }else if(selectedIndex == 1) {
    [self.view bringSubviewToFront:_mapView];
  }else {
    
  }
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

@end
