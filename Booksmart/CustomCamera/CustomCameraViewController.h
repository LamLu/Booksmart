//
//  CustomCameraViewController.h
//  CustomCamera
//
//  Created by Lam Lu on 7/5/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSessionManager.h"
#import <AVFoundation/AVFoundation.h>
#define kFinishCapturePhoto @"finishCapturePhoto"

@interface CustomCameraViewController : UIViewController <UIGestureRecognizerDelegate>


   
@property (nonatomic, retain) NSMutableArray * imageArray;
@property (weak, nonatomic) IBOutlet UIButton *flashButton;
@property (weak, nonatomic) IBOutlet UIView *toolbarView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail1;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail2;
@property (nonatomic, retain) CaptureSessionManager * captureManager;

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
- (IBAction)doneButtonClicked:(id)sender;
- (IBAction)capturePic:(id)sender;

- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)flashButtonClicked:(id)sender;

@end
