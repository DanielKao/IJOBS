//
//  iJobsWorkListModel.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkListModel.h"
#import "IJobsWorkListItem.h"
@implementation iJobsWorkListModel

@synthesize workListItems = _workListItems;

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
  
  if (!self.isLoading) {
    TTURLRequest *request = [TTURLRequest requestWithURL:kWorkListAPI delegate:self];
    request.cachePolicy = cachePolicy;
    request.cacheExpirationAge = TT_DEFAULT_CACHE_EXPIRATION_AGE;
    TTURLJSONResponse *response = [[[TTURLJSONResponse alloc] init] autorelease];
    request.response = response;
    [request send];
  }
  
}

- (void)requestDidFinishLoad:(TTURLRequest *)request {
  TTDPRINT(@"requestDidFinishLoad");
  TTURLJSONResponse *response = request.response;
  NSArray *itemsDictionary = response.rootObject;
  NSMutableArray *array = [NSMutableArray array];
  for(NSDictionary *item in itemsDictionary) {
    item = [item objectForKey:@"micropost"];
    
    TTDPRINT(@"item :%@", item);
    TTDPRINT(@"missionTitle: %@", [item objectForKey:@"missionTitle"]);
    TTDPRINT(@"missionDetail: %@", [item objectForKey:@"missionDetail"]);
    TTDPRINT(@"missionDate: %@", [item objectForKey:@"missionDate"]);
    TTDPRINT(@"missionLocation: %@", [item objectForKey:@"missionLocation"]);
    TTDPRINT(@"missionLocationAddress: %@", [item objectForKey:@"missionLocationAddress"]);
    TTDPRINT(@"customerID: %@", [item objectForKey:@"customerID"]);
    TTDPRINT(@"customerName: %@", [item objectForKey:@"customerName"]);
    TTDPRINT(@"workerID: %@", [item objectForKey:@"user_id"]);
    TTDPRINT(@"mission_complete: %@", [item objectForKey:@"mission_complete"]);
    
    IJobsWorkListItem *workItem = [[IJobsWorkListItem alloc] init];
    [workItem setMissionTitle:[item objectForKey:@"missionTitle"]];
    [workItem setMissionDetail:[item objectForKey:@"missionDetail"]];
    [workItem setCustomerID:[item objectForKey:@"customerID"]];
    [workItem setCustomerName:[item objectForKey:@"customerName"]];
    [workItem setWorkerID:[item objectForKey:@"user_id"]];
    [workItem setWorkerName:[item objectForKey:@"workerName"]];
    
    NSMutableString *workingDate = [NSMutableString stringWithString:[item objectForKey:@"missionDate"]];
    [workingDate replaceOccurrencesOfString:@"-" withString:@"/" options:2 range:NSMakeRange(0, [workingDate length])];
    [workingDate replaceOccurrencesOfString:@"T" withString:@" " options:2 range:NSMakeRange(0, [workingDate length])];
    [workingDate replaceOccurrencesOfString:@":00Z" withString:@"" options:2 range:NSMakeRange(0, [workingDate length])];

    [workItem setMissionDate:workingDate];
    
    [workItem setMissionLocationAddress:[item objectForKey:@"missionLocationAddress"]];
    [workItem setMissionLocation:[item objectForKey:@"missionLocation"]];
    if ([item objectForKey:@"mission_complete"] == 0) {
      [workItem setIsWorkDone:NO];
    } else {
      [workItem setIsWorkDone:YES];
    }
    [array addObject:workItem];
    TT_RELEASE_SAFELY(workItem);
   } 
  self.workListItems = [NSMutableArray arrayWithArray:array];
  [super requestDidFinishLoad:request];
}

- (void)dealloc
{
  TT_RELEASE_SAFELY(_workListItems);
  [super dealloc];
}


@end
