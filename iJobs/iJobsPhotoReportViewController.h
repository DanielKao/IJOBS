//
//  iJobsPhotoReportViewController.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/29.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol iJobsPhotoReportViewDelegate;

@interface iJobsPhotoReportViewController : UIViewController<TTPostControllerDelegate> {
  UIToolbar *_bottomToolbar;
  UIImagePickerController *_picker;
  UIImage *_situationImage;
  NSString *_situationDetail;
  NSString *_workID;
  id _delegate;
}

@property(nonatomic, retain) UIToolbar *bottomToolbar;
@property(nonatomic, retain) UIImagePickerController *picker;
@property(nonatomic, retain) UIImage *situationImage;
@property(nonatomic, retain) NSString *situationDetail;
@property(nonatomic, retain) NSString *workID;
@property(nonatomic, retain) id delegate;

- (id)initWithImage:(UIImage *)photo workID:(NSString *)workID imagePicker:(UIImagePickerController *)picker;

@end

@protocol iJobsPhotoReportViewDelegate<NSObject>
- (void)removePhotoReportViewController;
@end