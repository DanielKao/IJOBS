//
//  iJobsWorkListModel.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iJobsWorkListModel : TTURLRequestModel {
  NSMutableArray *_workListItems;
}

@property(nonatomic, retain) NSMutableArray *workListItems;

@end
