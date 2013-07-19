//
//  CaptureSessionManager.h
//  CustomCamera
//
//  Created by Lam Lu on 7/5/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#define kImageCapturedSuccessfully @"imageCapturedSuccessfully"

@interface CaptureSessionManager : NSObject

@property (nonatomic, retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, retain) UIImage *stillImage;

/**
 * AVCaptureSession for recording videos
 */
- (void)addVideoPreviewLayer;
- (void)addVideoInput;

/**
 * AVCaptureSession for still images
 */
- (void)addStillImageOutput;
- (void)captureStillImage;
@end
