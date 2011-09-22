//
//  iJobsWorkListDataSource.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkListDataSource.h"
#import "iJobsWorkListModel.h"
#import "iJobsWorkListItem.h"

@interface iJobsWorkListDataSource()
-(void)displayWorkDetailWithParameter:(NSString *)number;
@end

@implementation iJobsWorkListDataSource

@synthesize workListModel = _workListModel;

- (id)init {
  if ((self = [super init])) {
    TTNavigator *navigator = [TTNavigator navigator];
    TTURLMap *map = navigator.URLMap;
//    [map from:kWorkDetailPathWithParameter toObject:self selector:@selector(displayWorkDetailWithParameter:)];
    [map from:kWorkDetailPathWithParameter toViewController:self selector:@selector(displayWorkDetailWithParameter:)];
    _workListModel = [[iJobsWorkListModel alloc] init];
  }
  return self;
}

- (id)initWithMockupData {
  self = [self init];
  if (self) {
  }
  return self;
}

- (id)initWithWorkListAPI {
  self = [self init];
  if (self) {
  }
  return self;
}

- (void)dealloc
{
  TT_RELEASE_SAFELY(_workListModel);
  [super dealloc];
}

/*
 *  Ask for model
 */
/*
- (id<TTModel>)model {
  // TTDPRINT(@"Start");
  return _workListModel;
}
*/

- (void)tableViewDidLoadModel:(UITableView*)tableView {  

  iJobsWorkListItem *mockupItem = [[iJobsWorkListItem alloc] initWithTitle:@"待填" Detail:@"待填" Location:@"待填" date:@"待填" workerName:@"待填" workerID:@"待填" customerName:@"待填" customerID:@"待填"];

  self.workListModel.workListItems = [NSMutableArray arrayWithObjects:mockupItem,mockupItem,mockupItem,mockupItem,mockupItem, nil];
  
  NSMutableArray *array = [NSMutableArray array];
  
  for (int i = 0; i < 5; i++) {
    [array addObject:[TTTableMessageItem itemWithTitle:@"任務：(待填)" caption:@"客戶名稱：(待填)" text:@"工作內容：(待填) *設定accessoryURL以檢視完整工作內容" timestamp:[NSDate date] URL:[NSString stringWithFormat:kWorkDetailPathWithParameterNumber, i]]];
    TTDPRINT(@"item url: %@", [NSString stringWithFormat:kWorkDetailPathWithParameterNumber, i]);
  }
  self.items = array;
}

-(void)displayWorkDetailWithParameter:(NSString *)number {
  TTDPRINT(@"selected Item No. : %i", [number intValue]);
  TTURLAction *action = [[[TTURLAction actionWithURLPath:kWorkDetailPath] applyQuery:[NSDictionary dictionaryWithObject:[self.workListModel.workListItems objectAtIndex:[number intValue]] forKey:kParameterWorkItem]] applyAnimated:YES];

  [[TTNavigator navigator] openURLAction:action];
}
@end
