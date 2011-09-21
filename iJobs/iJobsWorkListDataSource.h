//
//  iJobsWorkListDataSource.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iJobsWorkListModel;

@interface iJobsWorkListDataSource : TTListDataSource {
  iJobsWorkListModel *_workListModel;
}

@property(nonatomic, retain) iJobsWorkListModel *workListModel;

- (id)initWithMockupData;
- (id)initWithWorkListAPI;

@end
