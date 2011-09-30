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
- (void)uploadImage:(NSString *)postedText;
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

  UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPhotoReportViewController)] autorelease];
  
  UIBarButtonItem *addCaptionButton = [[[UIBarButtonItem alloc] initWithTitle:@"加上註解" style:UIBarButtonItemStylePlain target:self action:@selector(addCaptionToImage)] autorelease];
  
  UIBarButtonItem *uploadButton = [[[UIBarButtonItem alloc] initWithTitle:@"上傳" style:UIBarButtonItemStylePlain target:self action:@selector(uploadImage:)] autorelease];
  
  UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] autorelease];
  
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
  UIImageView *imageView = [[[UIImageView alloc] initWithImage:self.image] autorelease];
  imageView.frame = imageFrame;
//  imageView.frame = CGRectMake(positionX, positionY, width, height);
  
  [self.view addSubview:imageView];
}

- (void)cancelPhotoReportViewController {
//  [_picker popToRootViewControllerAnimated:YES];
  [_picker popViewControllerAnimated:YES];
}
- (void)addCaptionToImage {
  [[TTNavigator navigator].URLMap from:@"tt://post"
                      toViewController:self selector:@selector(post:)];
  TTURLAction *action = [TTURLAction actionWithURLPath:@"tt://post"];
  [[TTNavigator navigator] openURLAction:action];

}
- (void)uploadImage:(NSString *)postedText {
  //use TTURLRequeseModel to upload image
}

- (UIViewController *)post:(NSDictionary*)query {
  TTPostController* controller = [[[TTPostController alloc] initWithNavigatorURL:nil query:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"text", self, @"delegate", nil]] autorelease];

  controller.originView = [query objectForKey:@"__target__"];
  return controller;
}


#pragma - TTPostController delegate

- (BOOL)postController:(TTPostController*)postController willPostText:(NSString*)text {
  [self uploadImage:text];
  return YES;
}
- (void)postController: (TTPostController*)postController
           didPostText: (NSString*)text
            withResult: (id)result {

}

- (void)postControllerDidCancel:(TTPostController*)postController {
  [_picker popViewControllerAnimated:YES];
}


@end
