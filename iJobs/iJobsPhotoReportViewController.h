//
//  iJobsPhotoReportViewController.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/29.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iJobsPhotoReportViewController : UIViewController {
  UIToolbar *_bottomToolbar;
  UIImagePickerController *_picker;
  UIImage *_image;
}

@property(nonatomic, retain) UIToolbar *bottomToolbar;
@property(nonatomic, retain) UIImagePickerController *picker;
@property(nonatomic, retain) UIImage *image;

- (id)initWithImage:(UIImage *)photo imagePicker:(UIImagePickerController *)picker;

@end
