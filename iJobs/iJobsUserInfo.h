//
//  iJobsUserInfo.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/28.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface iJobsUserInfo : NSObject {
  NSString *_userName;
  NSString *_userEmail;
  NSString *_userID;
  BOOL _admin;
}

@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *userEmail;
@property(nonatomic, copy) NSString *userID;
@property(nonatomic, readonly, getter = isAdmin) BOOL admin;

- (id)initWithUserName:(NSString *)name userEmail:(NSString *)email userId:(NSString *)ID admin:(BOOL)admin;
- (BOOL)isAdmin;
@end
