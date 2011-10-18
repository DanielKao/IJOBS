//
//  iJobsWorkDetailTableViewController.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/22.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class iJobsWorkListItem;
@class iJobsPhotoReportViewController;
@class iJobsGoogleMapViewController;
@class MKMapView;
@class iJobsSignatureViewController;
@interface iJobsWorkDetailTableViewController : TTTableViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, UIActionSheetDelegate> {
  iJobsWorkListItem *_workItem;
  iJobsGoogleMapViewController *_gMapViewController;
  iJobsSignatureViewController *_signatureViewController;
  MKMapView *_mapView;
  UIWebView *_webView;
}

@property(nonatomic, retain) iJobsWorkListItem *workItem;
@property(nonatomic, retain) iJobsGoogleMapViewController *gMapViewController;
@property(nonatomic, retain) iJobsSignatureViewController *signatureViewController;
@property(nonatomic, retain) MKMapView *mapView;
@property(nonatomic, retain) UIWebView *webView;
@end
