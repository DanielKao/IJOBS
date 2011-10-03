//
//  iJobsGoogleMapViewController.h
//  iJobs
//
//  Created by Daniel Kao on 2011/10/3.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
@interface iJobsGoogleMapViewController : UIViewController<MKMapViewDelegate> {
  MKMapView *_mapView;
}

@property(nonatomic, retain) MKMapView *mapView;


- (id)initWithFrame:(CGRect)frame;
@end
