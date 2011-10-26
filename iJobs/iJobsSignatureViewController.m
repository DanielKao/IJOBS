//
//  iJobsSignatureViewController.m
//  iJobs
//
//  Created by Daniel Kao on 2011/10/11.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsSignatureViewController.h"

@interface iJobsSignatureViewController()
- (void)cancelButton;
- (void)doneButton;
- (void)cleanScreen;
@end

@implementation iJobsSignatureViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 436)];
      [self.view setBackgroundColor:[UIColor lightGrayColor]];
      toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
      
      UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)] autorelease];
      
      UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButton)] autorelease];
      
      UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:@"客戶簽章" style:UIBarButtonItemStylePlain target:nil action:nil];

      UIBarButtonItem *flexibleItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
      
      [toolBar setItems:[NSArray arrayWithObjects:cancelButton, flexibleItem, titleButton, flexibleItem, doneButton, nil]];
      
      [self.view addSubview:toolBar];
      
      UIButton *redoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
      redoButton.frame = CGRectMake(20, 400, 80, 40);
      [redoButton setTitle:@"清除" forState:UIControlStateNormal];
      [redoButton addTarget:self action:@selector(cleanScreen) forControlEvents:UIControlEventTouchDown];
      [self.view addSubview:redoButton];
    }
    return self;
}

- (void)dealloc
{
  TT_RELEASE_SAFELY(toolBar);
  TT_RELEASE_SAFELY(drawImage);
  TT_RELEASE_SAFELY(_delegate);
  [super dealloc];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  drawImage = [[UIImageView alloc] initWithImage:nil];
	drawImage.frame = self.view.frame;
	[self.view addSubview:drawImage];
	self.view.backgroundColor = [UIColor lightGrayColor];
	mouseMoved = 0;  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
	
  /*
	if ([touch tapCount] == 2) {
		drawImage.image = nil;
		return;
	}
   */
  
	lastPoint = [touch locationInView:self.view];
	lastPoint.y -= 20;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];	
	CGPoint currentPoint = [touch locationInView:self.view];
	currentPoint.y -= 20;
	
	
	UIGraphicsBeginImageContext(self.view.frame.size);
	[drawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
//	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
  CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor blackColor] CGColor]);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
  
	mouseMoved++;
	
	if (mouseMoved == 10) {
		mouseMoved = 0;
	}
  
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 2) {
		drawImage.image = nil;
		return;
	}
	
	
	if(!mouseSwiped) {
		UIGraphicsBeginImageContext(self.view.frame.size);
		[drawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor blackColor] CGColor]);
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		CGContextFlush(UIGraphicsGetCurrentContext());
		drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
}

#pragma mark private method

- (void)cancelButton {
  [self dismissModalViewControllerAnimated:YES];
}

- (void)doneButton {
  if ([_delegate respondsToSelector:@selector(clientDidFinishSignature:)]) {
    TTDPRINT(@"delegate respondsToSelector:clientDidFinishSignature");
    [_delegate clientDidFinishSignature:drawImage];
  }
  [self dismissModalViewControllerAnimated:YES];
}

- (void)cleanScreen {
  /*
  [drawImage removeFromSuperview];
  TT_RELEASE_SAFELY(drawImage);
  drawImage = [[UIImageView alloc] initWithImage:nil];
  drawImage.frame = self.view.frame;
  mouseMoved = 0;  
  [self.view addSubview:drawImage];*/
  drawImage.image = nil;
  mouseMoved = 0;
}

@end
