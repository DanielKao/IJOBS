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
@synthesize missionLocation = _missionLocation;
@synthesize missionLocationAddress = _missionLocationAddress;
@synthesize missionDate = _missionDate;
@synthesize workerName = _workerName;
@synthesize workerID = _workerID;
@synthesize customerName = _customerName;
@synthesize customerID = _customerID;
@synthesize clientSignatureImageView = _clientSignatureImageView;
@synthesize latitude, longitude;


- (id)initWithTitle:(NSString *)title Detail:(NSString *)detail Location:(NSString *)location address:(NSString *)address date:(NSString *)date workerName:(NSString *)workerName workerID:(NSString *)workerID customerName:(NSString *)customerName customerID:(NSString *)customerID {
  if ((self = [super init])) {
    self.missionTitle = title;
    self.missionDetail = detail;
    self.missionLocationAddress = address;
    self.missionLocation = location;
    self.missionDate = date;
    self.workerName = workerName;
    self.workerID = workerID;
    self.customerName = customerName;
    self.customerID = customerID;
  }
  return self;
}

- (void)setClientSignatureImageView:(UIImageView *)signatureImageView {
  if (signatureImageView != nil) {
    _clientSignatureImageView = [signatureImageView retain];
    TTDPRINT(@"setClientSignatureImageView");
  }
}

- (void)dealloc
{
  TT_RELEASE_SAFELY(_missionTitle);
  TT_RELEASE_SAFELY(_missionDetail);
  TT_RELEASE_SAFELY(_missionDate);
  TT_RELEASE_SAFELY(_missionLocation);
  TT_RELEASE_SAFELY(_missionLocationAddress);
  TT_RELEASE_SAFELY(_workerID);
  TT_RELEASE_SAFELY(_workerName);
  TT_RELEASE_SAFELY(_customerID);
  TT_RELEASE_SAFELY(_customerName);
  TT_RELEASE_SAFELY(_clientSignatureImageView);
    [super dealloc];
}
@end
