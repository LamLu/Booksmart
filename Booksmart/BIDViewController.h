//
//  BIDViewController.h
//  Booksmart
//
//  Created by Thanh Au on 9/11/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTTSingleton.h"


@interface BIDViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;


- (IBAction)takePicture:(id)sender;
- (IBAction)selectExistingPicture:(id)sender;

- (IBAction)saveImageForProfile:(id)sender;


@end
