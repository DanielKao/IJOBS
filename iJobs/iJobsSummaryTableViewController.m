//
//  iJobsSummaryTableViewController.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsSummaryTableViewController.h"


@implementation iJobsSummaryTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"iJobs";
      self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"首頁" style:UIBarButtonItemStyleBordered target:nil action:nil];
      self.tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - TTModelViewController

- (void)createModel {
  self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
                     @"Section 1",
                     [TTTableTextItem itemWithText:@"工作清單" URL:kWorkListPath],
                     @"Section 2",
                     [TTTableTextItem itemWithText:@"地圖" URL:kMapPath],
                     @"Section 3",
                     [TTTableTextItem itemWithText:@"影像回報" URL:kCameraPath],
                     nil];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

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

@end
