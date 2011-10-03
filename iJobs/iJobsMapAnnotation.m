//
//  iJobsMapAnnotation.m
//  iJobs
//
//  Created by Daniel Kao on 2011/10/3.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsMapAnnotation.h"


@implementation iJobsMapAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (id)initWithCoords:(CLLocationCoordinate2D) coords title:(NSString *)title subtitle:(NSString *)subtitle {
  if ((self = [super init])) {
    _coordinate = coords;
    self.title = title;
    self.subtitle = subtitle;
  }
  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_title);
  TT_RELEASE_SAFELY(_subtitle);
  [super dealloc];
}

@end
