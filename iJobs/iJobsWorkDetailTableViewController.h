//
//  iJobsWorkDetailTableViewController.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/22.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iJobsWorkListItem;
@class iJobsPhotoReportViewController;
@class iJobsGoogleMapViewController;
@class MKMapView;
@interface iJobsWorkDetailTableViewController : TTTableViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
  iJobsWorkListItem *_workItem;
  iJobsGoogleMapViewController *_gMapViewController;
  MKMapView *_mapView;
}

@property(nonatomic, retain) iJobsWorkListItem *workItem;
@property(nonatomic, retain) iJobsGoogleMapViewController *gMapViewController;
@property(nonatomic, retain) MKMapView *mapView;
@end
