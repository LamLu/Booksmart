//
//  CustomCameraViewController.m
//  CustomCamera
//
//  Created by Lam Lu on 7/5/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "CustomCameraViewController.h"

@interface CustomCameraViewController ()

@end

@implementation CustomCameraViewController
@synthesize captureManager,toolbarView,thumbnail1, thumbnail2;
@synthesize flashButton, imageArray;
static int thumbnailIndex = 0;
static int flashmode = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    thumbnailIndex = 0;
 
    [self setCaptureManager:[[CaptureSessionManager alloc] init]];
    imageArray = [[NSMutableArray alloc] initWithCapacity:2];
	[self.captureManager addVideoInput];
    [self.captureManager addStillImageOutput];
	[self.captureManager addVideoPreviewLayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayImage) name:kImageCapturedSuccessfully object:nil];
    
    //UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    //OverlayViewController *overlayVC = [storyboard instantiateViewControllerWithIdentifier:@"CC"];
    // [self.view addSubview:overlayVC.view];
    
    CGRect layerRect = [self.view.layer bounds];
	[self.captureManager.previewLayer setBounds:layerRect];
	[self.captureManager.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                              CGRectGetMidY(layerRect))];
    
    [self.view.layer addSublayer:self.captureManager.previewLayer];
   
    
    [self.view addSubview:toolbarView];
    [self.view addSubview:flashButton];
    [self.view addSubview:thumbnail1];
    [self.view addSubview:thumbnail2];
	[captureManager.captureSession startRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/**
 * capture button is clicked
 */
- (IBAction)capturePic:(id)sender
{
    [self flashScreen];
    [self.captureManager captureStillImage];

}

/**
 * done button is clicked. stop the video session and dismiss the view
 */
- (IBAction)doneButtonClicked:(id)sender
{
    [self.captureManager.captureSession stopRunning];
     [[NSNotificationCenter defaultCenter] postNotificationName:kFinishCapturePhoto object:nil];
    [self dismissModalViewControllerAnimated:YES];
}
/**
 * cancel button is clicked. stop the video session and dismiss the view
 */

- (IBAction)cancelButtonClicked:(id)sender
{
    [self.captureManager.captureSession stopRunning];
    imageArray = nil;
    [self dismissModalViewControllerAnimated:YES];
}

/**
 * turn on and off flash
 */
- (IBAction)flashButtonClicked:(id)sender
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasFlash])
    {
        NSError * error = nil;
        if ([device lockForConfiguration:&error])
        {
            //if flash mode is off
            if (flashmode == 0)
            {
                [device setTorchMode:AVCaptureTorchModeOn];
                flashmode = 1;
            }
            else if (flashmode == 1)
            {
                [device setTorchMode:AVCaptureTorchModeOff];
                flashmode = 0;
            }
            [device unlockForConfiguration];
        }
        else
        {
            NSLog (@"%@", error);
        }
    }
    device = nil;
}

/**
 * function to display the images on the thumbnails
 */
- (void) displayImage
{
    int index = thumbnailIndex % 2;
    if (index == 0)
        thumbnail1.image = [self.captureManager stillImage];
    else
        thumbnail2.image = [self.captureManager stillImage];
    
    thumbnailIndex++;
    
    if (imageArray.count >= 2 )
    {
        [imageArray removeObjectAtIndex:index];
    }
    
    UIImage *newImage = [self squareImageWithImage:[self.captureManager stillImage] scaledToSize:CGSizeMake(350, 350)];
    [imageArray insertObject:newImage atIndex:index];
    newImage = nil;
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
    else {
        
    }
}


/**
 * screen is flashed when capture button is clicked
 */
- (void)flashScreen
{
    CGFloat height = self.view.frame.size.height - self.toolbarView.frame.size.height;
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, height);
	//make the view if we haven't already and add it as a subview
    __block  UIView *flashView = [[UIView alloc] initWithFrame: frame];
    [flashView setBackgroundColor:[UIColor whiteColor]];
    [flashView setAlpha:0.f];
    [self.view addSubview:flashView];
    
    [UIView animateWithDuration:.5f
                     animations:^{
                         [flashView setAlpha:1.f];
                         [flashView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         [flashView removeFromSuperview];
                         flashView = nil;
                     }
	 ];
    
}

- (void)viewDidUnload {
    [self setToolbarView:nil];
    [self setThumbnail1:nil];
    [self setThumbnail2:nil];
    [self setFlashButton:nil];
    [super viewDidUnload];
    imageArray = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
	[self.captureManager.captureSession stopRunning];
}



/**
 All credit for this function belongs to Sam @
 www.samwirch.com/blog/cropping-and-resizing-images-camera-ios-and-objective-c
 */

- (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);

    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
