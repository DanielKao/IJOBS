//
//  iJobsUserInfo.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/28.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsUserInfo.h"


@implementation iJobsUserInfo

@synthesize userName = _userName;
@synthesize userEmail = _userEmail;
@synthesize userID = _userID;

- (id)initWithUserName:(NSString *)name userEmail:(NSString *)email userId:(NSString *)ID admin:(BOOL)admin {
  if ((self = [super init])) {
    self.userName = name;
    self.userEmail = email;
    self.userID = ID;
    _admin = admin;
  }
  return self;
}

- (BOOL)isAdmin {
  return _admin;
}
@end
