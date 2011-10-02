//
//  iJobsAppDelegate.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsAppDelegate.h"
#import "iJobsSummaryTableViewController.h"
#import "iJobsWorkListTableViewController.h"
#import "iJobsWorkDetailTableViewController.h"
@implementation iJobsAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  TTNavigator *navigator = [TTNavigator navigator];
  navigator.persistenceMode = TTNavigatorPersistenceModeAll;
  navigator.window = _window;
  TTURLMap *map = navigator.URLMap;
  [map from:@"*" toViewController:[TTWebController class]];
  //[map from:kRootPath toViewController:[iJobsSummaryTableViewController class]];
  [map from:kRootPath toViewController:[iJobsWorkListTableViewController class]];
  /*This is for mockup data, after the API is completed, selector should change*/
  [map from:kWorkListPath toViewController:[iJobsWorkListTableViewController class]];
  [map from:kWorkDetailPath toViewController:[iJobsWorkDetailTableViewController class]];
  [map from:kCameraPath toModalViewController:[UIImagePickerController class]];
//  if (![navigator restoreViewControllers]) {
    [navigator openURLAction:[TTURLAction actionWithURLPath:kRootPath]];
  //}
  return YES;
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
  [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}

- (void)dealloc
{
  TT_RELEASE_SAFELY(_window);
    [super dealloc];
}

@end
