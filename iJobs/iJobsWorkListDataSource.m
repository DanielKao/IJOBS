//
//  iJobsWorkListDataSource.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkListDataSource.h"
#import "iJobsWorkListModel.h"
#import "IJobsWorkListItem.h"

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

- (id<TTModel>)model {
  // TTDPRINT(@"Start");
  return _workListModel;
}


- (void)tableViewDidLoadModel:(UITableView*)tableView {  

//  IJobsWorkListItem *mockupItem = [[IJobsWorkListItem alloc] initWithTitle:@"會見政大老闆" Detail:@"洽談政大資訊教室電腦裝配外包事宜" Location:@"國立政治大學" address:@"台北市文山區指南路2段64號" date:@"2012/10/03 15:00" workerName:@"王小華" workerID:@"w11111" customerName:@"吳濕華" customerID:@"c11111"];
//  
//  IJobsWorkListItem *mockupItem2 = [[IJobsWorkListItem alloc] initWithTitle:@"會見蔡小英" Detail:@"洽談民小黨競選總部資訊設備架設事宜" Location:@"新光三越南西店一館" address:@"104台北市南京西路12號" date:@"2012/10/04 15:00" workerName:@"王小華" workerID:@"w11111" customerName:@"蔡小英" customerID:@"c11112"];
//  
//  IJobsWorkListItem *mockupItem3 = [[IJobsWorkListItem alloc] initWithTitle:@"會見馬小九" Detail:@"洽談國小黨競選總部資訊設備架設事宜" Location:@"太平洋SOGO百貨復興館" address:@"106台北市忠孝東路三段300號" date:@"2012/10/04 18:00" workerName:@"王小華" workerID:@"w11111" customerName:@"馬小九" customerID:@"c11113"];
//  
//  IJobsWorkListItem *mockupItem4 = [[IJobsWorkListItem alloc] initWithTitle:@"會見相聲瓦舍宋少卿先生" Detail:@"洽談相聲瓦舍排練場電腦與錄影設備裝配事宜" Location:@"相聲瓦舍劇團總部" address:@"新北市新店區北新路2段64號" date:@"2012/10/05 12:00" workerName:@"王小華" workerID:@"w11111" customerName:@"宋少卿" customerID:@"c11114"];

//  self.workListModel.workListItems = [NSMutableArray arrayWithObjects:mockupItem,mockupItem2,mockupItem3,mockupItem4, nil];
  
  NSMutableArray *array = [NSMutableArray array];
  NSArray *temp = [self.workListModel.workListItems retain];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
  
  for (IJobsWorkListItem *item in temp) {
    
    [array addObject:
     [TTTableMessageItem itemWithTitle:[NSString stringWithFormat:@"任務:%@", item.missionTitle] 
                               caption:[NSString stringWithFormat:@"客戶名稱:%@", item.customerName] 
                                  text:[NSString stringWithFormat:@"%@", item.missionDetail]
                             timestamp:[dateFormatter dateFromString:item.missionDate] 
                         URL:[NSString stringWithFormat:kWorkDetailPathWithParameterNumber, [temp indexOfObject:item]]]];
  }
  self.items = array;
  
  TT_RELEASE_SAFELY(dateFormatter);
  TT_RELEASE_SAFELY(temp);
}

-(void)displayWorkDetailWithParameter:(NSString *)number {
  TTDPRINT(@"selected Item No. : %i", [number intValue]);
  TTURLAction *action = [[[TTURLAction actionWithURLPath:kWorkDetailPath] applyQuery:[NSDictionary dictionaryWithObject:[self.workListModel.workListItems objectAtIndex:[number intValue]] forKey:kParameterWorkItem]] applyAnimated:YES];

  [[TTNavigator navigator] openURLAction:action];
}

@end
