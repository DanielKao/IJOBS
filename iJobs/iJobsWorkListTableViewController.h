//
//  iJobsWorkListTableViewController.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iJobsWorkListTableViewDelegate;
@interface iJobsWorkListTableViewController : TTTableViewController {
  iJobsWorkListTableViewDelegate *_tableViewDelegate;
}

@property(nonatomic, retain) iJobsWorkListTableViewDelegate *tableViewDelegate;

@end
