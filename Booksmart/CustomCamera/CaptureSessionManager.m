//
//  CaptureSessionManager.m
//  CustomCamera
//
//  Created by Lam Lu on 7/5/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "CaptureSessionManager.h"

@implementation CaptureSessionManager
@synthesize captureSession,previewLayer;
@synthesize stillImage,stillImageOutput;

- (id)init {
	if ((self = [super init])) {
		[self setCaptureSession:[[AVCaptureSession alloc] init]];
	}
	return self;
}

- (void)addVideoPreviewLayer {
	[self setPreviewLayer:[[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession]];
	[self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
}

- (void)addVideoInput {
	AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (videoDevice) {
		NSError *error;
		AVCaptureDeviceInput *videoIn =
        [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		if (!error) {
			if ([[self captureSession] canAddInput:videoIn])
				[[self captureSession] addInput:videoIn];
			else
				NSLog(@"Couldn't add video input");
		}
		else
			NSLog(@"Couldn't create video input");
	}
	else
		NSLog(@"Couldn't create video capture device");
}

- (void)addStillImageOutput
{
    [self setStillImageOutput:[[AVCaptureStillImageOutput alloc] init]];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in [self.stillImageOutput connections]) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [self.captureSession addOutput:[self stillImageOutput]];
}

- (void)captureStillImage
{
	AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) {
            break;
        }
	}
    
	//NSLog(@"about to request a capture from: %@", [self stillImageOutput]);
	[[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection
                                                         completionHandler:^
     (CMSampleBufferRef imageSampleBuffer, NSError *error)
    {
        CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
        if (exifAttachments)
        {
          //  NSLog(@"attachements: %@", exifAttachments);
        } else
        {
            NSLog(@"no attachments");
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        [self setStillImage:image];
        image = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:kImageCapturedSuccessfully object:nil];
    }];
}


@end
