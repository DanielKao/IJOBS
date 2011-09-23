//
//  iJobsWorkDetailTableViewController.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/22.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkDetailTableViewController.h"
#import "iJobsWorkListItem.h"

@interface iJobsWorkDetailTableViewController()
- (NSMutableArray *)arrayWithWorkDetailTableItem:(iJobsWorkListItem *)workItem;
- (void)addSegmentedControll;
- (void)actionsForSegment:(id)sender;
@end

@implementation iJobsWorkDetailTableViewController

@synthesize workItem = _workItem;

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
    TTDPRINT(@"workItem :%@", self.workItem);
  }
  return self;
}


- (void)dealloc
{
  TT_RELEASE_SAFELY(_workItem);
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
  
  NSMutableArray *detailItems = [self arrayWithWorkDetailTableItem:self.workItem];
  self.dataSource = [TTListDataSource dataSourceWithItems:detailItems];
  [self addSegmentedControll];
  }

- (void)addSegmentedControll {
  
  CGFloat positionY = self.view.bounds.size.height - self.navigationController.navigationBar.height;
  
  UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"工作說明", @"地圖", @"街景", @"影像回報", nil]];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

}

@end
