//
//  iJobsSignatureViewController.h
//  iJobs
//
//  Created by Daniel Kao on 2011/10/11.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iJobsSignatureViewController : TTViewController {

  UIToolbar *toolBar;
  CGPoint lastPoint;
	UIImageView *drawImage;
	BOOL mouseSwiped;	
	int mouseMoved;
}

@end
