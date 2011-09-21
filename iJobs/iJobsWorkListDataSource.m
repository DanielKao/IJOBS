//
//  iJobsWorkListDataSource.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkListDataSource.h"
#import "iJobsWorkListModel.h"

@implementation iJobsWorkListDataSource

@synthesize workListModel = _workListModel;

- (id)initWithMockupData {
  self = [super init];
  if (self) {
    TTTableMessageItem *testItem = [TTTableMessageItem itemWithTitle:@"任務：(待填)" caption:@"客戶名稱：(待填)" text:@"工作內容：(待填) *設定accessoryURL以檢視完整工作內容" timestamp:[NSDate date] imageURL:nil URL:@"tw.yahoo.com"];
    self.items = [NSArray arrayWithObjects:testItem,testItem,testItem,testItem,testItem,nil];
  }
  return self;
}

- (id)initWithWorkListAPI {
  self = [super init];
  if (self) {
    _workListModel = [[iJobsWorkListModel alloc] init];
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

}


@end
