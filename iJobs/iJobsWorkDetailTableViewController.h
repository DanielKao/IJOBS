//
//  iJobsWorkDetailTableViewController.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/22.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iJobsWorkListItem;
@class iJobsPhotoReportViewController;

@interface iJobsWorkDetailTableViewController : TTTableViewController<UIImagePickerControllerDelegate> {
  iJobsWorkListItem *_workItem;
}

@property(nonatomic, retain) iJobsWorkListItem *workItem;

@end
