//
//  iJobsWorkListModel.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsWorkListModel.h"


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
  /*
  TTURLJSONResponse *response = request.response;
  NSDictionary *itemsDictionary = response.rootObject;
  NSArry *items = [itemsDictionary objectForKey:@"待填"];
  //items array中，每一個element均代表一筆record , 每個record又是一個dictionary
  for(NSDictionary *item in items) {
    //解析items中的每一筆record，並將每筆資料存成iJobsWorkListItem, 最後加入_workListItems.
    //iJobWorkListItem的property未必與record的attribute相同，待API完成後確認.
   } 
  */
}

- (void)dealloc
{
    [super dealloc];
}


@end
