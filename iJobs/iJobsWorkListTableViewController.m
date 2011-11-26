//
//  iJobsWorkListTableViewController.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkListTableViewController.h"
#import "iJobsWorkListDataSource.h"
#import "iJobsWorkListTableViewDelegate.h"
#import "iJobsUserLoginManager.h"
#import "DDAlertPrompt.h"

@interface iJobsWorkListTableViewController()
- (void)loginPrompt;
- (void)loginWithUserEmail:(NSString *)userEmail userPassword:(NSString *)userPassword;
- (void)logout;
- (void)changeLoginButton:(NSNotification *)notification;
- (void)cleanUpTableView;
@end

@implementation iJobsWorkListTableViewController

@synthesize tableViewDelegate = _tableViewDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"工作清單";
      self.variableHeightRows = YES;
      //_tableViewDelegate = [[iJobsWorkListTableViewDelegate alloc] initWithController:self];
      self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"登入" style:UIBarButtonItemStyleBordered target:self action:@selector(loginPrompt)] autorelease];
      self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload)] autorelease];
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginButton:) name:kLoginNotification object:nil];
  [self loginPrompt];
  
}

- (void)viewDidUnload {
  [super viewDidUnload];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)createModel {
//  self.dataSource = [[iJobsWorkListDataSource alloc] initWithWorkListAPI];
  BOOL isUserLogin = [[iJobsUserLoginManager sharedInstance] isUserLogin];
  [[iJobsUserLoginManager sharedInstance] setDelegate:self];

  if (isUserLogin) {
    self.dataSource = [[iJobsWorkListDataSource alloc] initWithWorkListAPI];
  }
  
}

#pragma - private method

- (void)cleanUpTableView {
  self.dataSource = [[[TTListDataSource alloc] init] autorelease];
  [self refresh];
}

- (void)loginPrompt {
  DDAlertPrompt *loginPrompt = [[DDAlertPrompt alloc] initWithTitle:@"Sign in to iJobs" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitle:@"Sign In"]; 
  [loginPrompt show];
  [loginPrompt release];
}

- (void)loginWithUserEmail:(NSString *)userEmail userPassword:(NSString *)userPassword {
  iJobsUserLoginManager *userLoginManager = [iJobsUserLoginManager sharedInstance];
  [userLoginManager loginWithUserEmail:userEmail password:userPassword];
}

- (void)changeLoginButton:(NSNotification *)notification {
  self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"登出" style:UIBarButtonItemStyleBordered target:self action:@selector(logout)] autorelease];
}

- (void)logout {
  [[iJobsUserLoginManager sharedInstance] logout];
  self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"登入" style:UIBarButtonItemStyleBordered target:self action:@selector(loginPrompt)] autorelease];
  [self cleanUpTableView];
  
  //TODO: clean workList after logout.

}
#pragma - DDAlertPrompt Delegate

- (void)didPresentAlertView:(UIAlertView *)alertView {
  if ([alertView isKindOfClass:[DDAlertPrompt class]]) {
    DDAlertPrompt *loginPrompt = (DDAlertPrompt *)alertView;
    [loginPrompt.plainTextField becomeFirstResponder];      
    [loginPrompt setNeedsLayout];
  }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex == [alertView cancelButtonIndex]) {
  } else {
    if ([alertView isKindOfClass:[DDAlertPrompt class]]) {
      DDAlertPrompt *loginPrompt = (DDAlertPrompt *)alertView;
      [self loginWithUserEmail:loginPrompt.plainTextField.text userPassword:loginPrompt.secretTextField.text];
    }
  }
}

#pragma - iJobsUserLoginManagerDelegate

- (void)userDidFinishLogin:(TTURLRequest *)request {
  [self createModel];
}



@end
