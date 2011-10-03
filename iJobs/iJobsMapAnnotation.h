//
//  iJobsMapAnnotation.h
//  iJobs
//
//  Created by Daniel Kao on 2011/10/3.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface iJobsMapAnnotation : NSObject <MKAnnotation>{
  CLLocationCoordinate2D _coordinate;
	NSString *_subtitle;
	NSString *_title;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *subtitle;

- (id)initWithCoords:(CLLocationCoordinate2D) coords title:(NSString *)title subtitle:(NSString *)subtitle;
@end


