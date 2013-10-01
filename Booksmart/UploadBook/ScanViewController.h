//
//  ScanViewController.h
//  Booksmart
//
//  Created by Thanh Au on 9/4/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "UploadBookConnection.h"
#import "CustomCameraViewController.h"
#import "UploadOptionViewController.h"
@interface ScanViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate ,ZBarReaderDelegate, ProcessAfterUpload>

{
    NSString * bookInfoOutput;
    NSString * bookTitle;
    NSString * bookEdition;
    NSString * bookISBN10;
    NSString * bookISBN13;
    NSString * bookPublisher;
    NSMutableString * bookAuthors;
    NSString * bookSubject;
    NSMutableArray* imgArr;
}
@property (weak, nonatomic) IBOutlet UIImageView *bookCoverImageView;
@property (weak, nonatomic) IBOutlet UITextView *bookInfoTextField;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail1;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail2;
@property (weak, nonatomic) CustomCameraViewController * cameraVC;
@property (nonatomic,retain) UIAlertView *resultAlertView;

// submit button is clicked. option view is presented
- (IBAction)submitButtonClicked:(id)sender;

//action when barcode scan button is clicked
- (IBAction)barcodeScanButtonClicked:(id)sender;

//action when upload to inventory button is clicked
- (void) uploadToInventory;

//action when upload to wishlist button is clicked
- (void)uploadToWishList;

// delegation method, refer to the method in Connection class
- (void) isUploadSuccessful : (BOOL)upload;

- (IBAction)cameraButtonClicked:(id)sender;
@end
