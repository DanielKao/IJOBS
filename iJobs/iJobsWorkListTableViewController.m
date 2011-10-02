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
@interface iJobsWorkListTableViewController()
- (void)login;
@end

@implementation iJobsWorkListTableViewController

@synthesize tableViewDelegate = _tableViewDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"工作清單";
      self.variableHeightRows = YES;
      //_tableViewDelegate = [[iJobsWorkListTableViewDelegate alloc] initWithController:self];
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登入" style:UIBarButtonItemStyleBordered target:self action:@selector(login)];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)createModel {
//  self.dataSource = [[iJobsWorkListDataSource alloc] initWithWorkListAPI];
  self.dataSource = [[iJobsWorkListDataSource alloc] initWithMockupData];
}

#pragma - private method

- (void)login {

}

@end
