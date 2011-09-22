//
//  iJobsWorkListTableViewController.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkListTableViewController.h"
#import "iJobsWorkListDataSource.h"
#import "iJobsWorkListTableViewDelegate.h"
@implementation iJobsWorkListTableViewController

@synthesize tableViewDelegate = _tableViewDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"工作清單";
      self.variableHeightRows = YES;
      //_tableViewDelegate = [[iJobsWorkListTableViewDelegate alloc] initWithController:self];
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

- (void)createModel {
//  self.dataSource = [[iJobsWorkListDataSource alloc] initWithWorkListAPI];
  self.dataSource = [[iJobsWorkListDataSource alloc] initWithMockupData];
}
@end
