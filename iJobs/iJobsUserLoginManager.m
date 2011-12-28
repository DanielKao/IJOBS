//
//  iJobsUserLoginManager.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/28.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsUserLoginManager.h"
#import "iJobsUserInfo.h"

@implementation iJobsUserLoginManager

#define SESSION_EXPIRED_MINS 240

@synthesize userInfo = _userInfo;
@synthesize errorMessage = _errorMessage;
@synthesize delegate = _delegate;
//@synthesize userAccount = _userAccount;
//@synthesize userPassword = _userPassword;

static iJobsUserLoginManager *gSharedInstance;

+ (iJobsUserLoginManager *)sharedInstance {
  @synchronized(self) {
    if (gSharedInstance == nil) {
      gSharedInstance = [[iJobsUserLoginManager alloc] init];
    }
  }
  return gSharedInstance;
}

- (id)init {
  if ((self = [super init])) {
    
  }
  return self;
}

- (id)retain {
  return self;
}

- (NSUInteger)retainCount {
  return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
  //do nothing
}

- (id)autorelease {
  return self;
}

- (void)logout {
  //you should add use a sign-out API here.
  TTURLRequest *request = [TTURLRequest requestWithURL:kLogoutAPI delegate:self];
  request.httpMethod = @"GET";
  request.cachePolicy = TTURLRequestCachePolicyNone;
  [request send];
  
  TT_RELEASE_SAFELY(_userInfo);
  TT_RELEASE_SAFELY(_errorMessage);
}

- (void)loginWithUserEmail:(NSString *)userEmail password:(NSString *)userPassword {

  TTURLRequest *request = [TTURLRequest requestWithURL:kLoginAPI delegate:self];
  request.httpMethod = @"POST";
  
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  NSString *deviceToken = [userDefault objectForKey:@"deviceToken"];
  NSLog(@"deviceToken: %@", deviceToken);
  [request.parameters setObject:userEmail forKey:@"email"];
  [request.parameters setObject:userPassword forKey:@"password"];
  if (deviceToken != nil) {
    [request.parameters setObject:deviceToken forKey:@"device_token"]; 
  }
  request.cachePolicy = TTURLRequestCachePolicyNone;
  request.response = [[[TTURLJSONResponse alloc] init] autorelease];
  
  [request send];
}

- (BOOL)isUserLogin {
  if (_userInfo == nil) {
    return NO;
  } else {
    return YES;
  }
}

#pragma mark -
#pragma mark TTURLRequest methods

- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
  
  NSData *responseData = [[error userInfo] objectForKey:@"responsedata"];
  _errorMessage = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
  TTDPRINT(@"errorMessage: %@", _errorMessage);
  
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"錯誤" message:@"請檢查帳號密碼或洽系統管理員" delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
  [alertView show];
  TT_RELEASE_SAFELY(alertView);
  [super request:request didFailLoadWithError:error];
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
  
  if (request.urlPath == kLoginAPI) {
    TTURLJSONResponse *response = request.response;
    NSDictionary *itemsDictionary = response.rootObject;
    
    if ([itemsDictionary objectForKey:@"error_message"]) {
      TTDPRINT(@"error_message: %@", [itemsDictionary objectForKey:@"error_message"]);
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"錯誤" message:@"請檢查帳號密碼或洽系統管理員" delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
      [alertView show];
      TT_RELEASE_SAFELY(alertView);
    }else {
    TTDPRINT(@"Show user info itemsDictionary: %@", itemsDictionary);
    TTDASSERT(([[itemsDictionary objectForKey:@"current_user"] isKindOfClass:[NSDictionary class]]));
    NSDictionary *userInfoDicionary = [itemsDictionary objectForKey:@"current_user"];
    
    _userInfo = [[iJobsUserInfo alloc] initWithUserName:[userInfoDicionary objectForKey:@"name"] userEmail:[userInfoDicionary objectForKey:@"email"] userId:[userInfoDicionary objectForKey:@"id"] admin:[[userInfoDicionary objectForKey:@"admin"] boolValue]];
    
//    [_delegate userDidFinishLogin:request];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object:nil];
    }
  }else {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNotification object:nil];
  }
  
  
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    [_delegate loginPrompt];
  }
}

@end
