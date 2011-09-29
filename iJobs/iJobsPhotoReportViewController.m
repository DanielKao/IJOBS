//
//  iJobsPhotoReportViewController.m
//  iJobs
//
//  Created by Daniel Kao on 2011/9/29.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#import "iJobsPhotoReportViewController.h"

@interface iJobsPhotoReportViewController()
//static UIImage *shrinkImage(UIImage *original, CGSize size, CGPoint origin);
- (void)initializeBottomToolbar;
- (void)initializeImageView;
- (void)cancelPhotoReportViewController;
- (void)addCaptionToImage;
- (void)uploadImage;
@end


@implementation iJobsPhotoReportViewController

@synthesize bottomToolbar = _bottomToolbar;
@synthesize picker = _picker;
@synthesize image = _image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (id)initWithImage:(UIImage *)photo imagePicker:(UIImagePickerController *)picker {
  if ((self = [self initWithNibName:nil bundle:nil])) {
    self.image = photo;
    self.picker = picker;    
  }
  return self;
}

- (void)dealloc
{
  TT_RELEASE_SAFELY(_image);
  TT_RELEASE_SAFELY(_picker);
  TT_RELEASE_SAFELY(_bottomToolbar);
  [super dealloc];
}

#pragma mark - View lifecycle


- (void)loadView
{
  [super loadView];
  [self initializeImageView];
  [self initializeBottomToolbar];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)initializeBottomToolbar {
  
  CGFloat positionX = 0;
  CGFloat positionY = self.view.bounds.size.height - self.navigationController.navigationBar.height;
  CGFloat width = 320;
  CGFloat height = self.navigationController.navigationBar.height;
  
  _bottomToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(positionX, positionY, width, height)];

  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPhotoReportViewController)];
  
  UIBarButtonItem *addCaptionButton = [[UIBarButtonItem alloc] initWithTitle:@"加上註解" style:UIBarButtonItemStylePlain target:self action:@selector(AddCaptionToImage)];
  
  UIBarButtonItem *uploadButton = [[UIBarButtonItem alloc] initWithTitle:@"回報" style:UIBarButtonItemStylePlain target:self action:@selector(uploadImage)];
  
  UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
  
  [_bottomToolbar setItems:[NSArray arrayWithObjects:cancelButton, flexibleSpace,addCaptionButton, flexibleSpace, uploadButton, nil]];
  
  [self.view addSubview:_bottomToolbar];
}

- (void)initializeImageView {
  CGFloat positionX = 0;
  CGFloat positionY = self.navigationController.navigationBar.height;
  CGFloat height = self.view.size.height - positionY*2;
  CGFloat width = 320;
  CGRect imageFrame = CGRectMake(positionX, positionY, width, height);
//  UIImage *shrunkemImage = shrinkImage(self.image, imageFrame.size, imageFrame.origin);
  UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
  imageView.frame = imageFrame;
//  imageView.frame = CGRectMake(positionX, positionY, width, height);
  
  [self.view addSubview:imageView];
}

/*
#pragma mark - 
static UIImage *shrinkImage(UIImage *original, CGSize size, CGPoint origin) {
  TTDPRINT(@"originY: %f", origin.y);
  CGFloat scale = [UIScreen mainScreen].scale; CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale, size.height * scale, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
  CGContextDrawImage(context,
                     CGRectMake(origin.x, origin.y, size.width * scale, size.height * scale),
                     original.CGImage); 
  CGImageRef shrunken = CGBitmapContextCreateImage(context); 
  UIImage *final = [UIImage imageWithCGImage:shrunken];
  CGContextRelease(context); 
  CGImageRelease(shrunken);
  return final;
}
 */

- (void)cancelPhotoReportViewController {
  [_picker popToRootViewControllerAnimated:YES];
}
- (void)addCaptionToImage {
  
}
- (void)uploadImage {

}

@end
