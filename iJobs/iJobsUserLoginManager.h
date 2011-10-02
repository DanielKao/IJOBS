//
//  iJobsUserLoginManager.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/28.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class iJobsUserInfo;
@interface iJobsUserLoginManager : TTURLRequestModel {
  iJobsUserInfo *_userInfo;
  NSString *_errorMessage;
}

@property(nonatomic, retain) iJobsUserInfo *userInfo;
@property(nonatomic, copy) NSString *errorMessage;
//@property(nonatomic, retain) NSString *userAccount;
//@property(nonatomic, retain) NSString *userPassword;

+ (iJobsUserLoginManager *)sharedInstance;
- (void)loginWithUserEmail:(NSString *)userEmail password:(NSString *)userPassword;
- (void)logout;
- (BOOL)isUserLogin;

@end
