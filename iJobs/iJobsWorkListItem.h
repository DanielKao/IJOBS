//
//  iJobsWorkListItem.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iJobsWorkListItem : NSObject {
    /* 用來接收工作清單的每筆資料, iVar待確認*/
  NSString *_missionTitle;
  NSString *_missionDetail;
  NSString *_missionLocationAddress;
  NSString *_missionDate;
  NSString *_workerName;
  NSString *_workerID;
  NSString *_customerName;
  NSString *_customerID;
}

@property(nonatomic, retain) NSString *missionTitle;
@property(nonatomic, retain) NSString *missionDetail;
@property(nonatomic, retain) NSString *missionLocationAddress;
@property(nonatomic, retain) NSString *missionDate;
@property(nonatomic, retain) NSString *workerName;
@property(nonatomic, retain) NSString *workerID;
@property(nonatomic, retain) NSString *customerName;
@property(nonatomic, retain) NSString *customerID;
          

@end
