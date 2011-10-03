//
//  iJobsGoogleMapViewController.m
//  iJobs
//
//  Created by Daniel Kao on 2011/10/3.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsGoogleMapViewController.h"
#import "MapKit/MapKit.h"

@implementation iJobsGoogleMapViewController

@synthesize mapView = _mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
  
  if ((self = [self initWithNibName:nil bundle:nil])) {
    _mapView = [[MKMapView alloc] initWithFrame:frame];
    _mapView.delegate = self;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    _mapView.tag = 1; 
    
    
  }
  return self;
}

- (void)dealloc
{
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
  self.view.frame = _mapView.frame;
  [self.view addSubview:_mapView];
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

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
