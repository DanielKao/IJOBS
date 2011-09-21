//
//  iJobsWorkListItem.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkListItem.h"


@implementation iJobsWorkListItem

@synthesize missionTitle = _missionTitle;
@synthesize missionDetail = _missionDetail;
@synthesize missionLocationAddress = _missionLocationAddress;
@synthesize missionDate = _missionDate;
@synthesize workerName = _workerName;
@synthesize workerID = _workerID;
@synthesize customerName = _customerName;
@synthesize customerID = _customerID;

- (id)initWithTitle:(NSString *)title Detail:(NSString *)detail Location:(NSString *)location date:(NSString *)date workerName:(NSString *)workerName workerID:(NSString *)workerID customerName:(NSString *)customerName customerID:(NSString *)customerID {
  if ((self = [super init])) {
    self.missionTitle = title;
    self.missionDetail = detail;
    self.missionLocationAddress = location;
    self.missionDate = date;
    self.workerName = workerName;
    self.workerID = workerID;
    self.customerName = customerName;
    self.customerID = customerID;
  }
  return self;
}

- (void)dealloc
{
  TT_RELEASE_SAFELY(_missionTitle);
  TT_RELEASE_SAFELY(_missionDetail);
  TT_RELEASE_SAFELY(_missionDate);
  TT_RELEASE_SAFELY(_missionLocationAddress);
  TT_RELEASE_SAFELY(_workerID);
  TT_RELEASE_SAFELY(_workerName);
  TT_RELEASE_SAFELY(_customerID);
  TT_RELEASE_SAFELY(_customerName);
    [super dealloc];
}
@end
