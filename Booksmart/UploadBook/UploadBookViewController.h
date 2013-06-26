//
//  UploadBookViewController.h
//  Booksmart
//
//  Created by Lam Lu on 6/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "UploadBookConnection.h"

@interface UploadBookViewController : UIViewController <ZBarReaderDelegate, ProcessAfterUpload>
{
    NSString * bookInfoOutput;
    NSString * bookTitle;
    NSString * bookEdition;
    NSString * bookISBN10;
    NSString * bookISBN13;
    NSString * bookPublisher;
    NSMutableString * bookAuthors;
    NSString * bookSubject;
}

@property (weak, nonatomic) IBOutlet UIImageView *bookCoverImageView;
@property (weak, nonatomic) IBOutlet UITextView *bookInfoTextField;

//action when barcode scan button is clicked
- (IBAction)barcodeScanButtonClicked:(id)sender;

//action when submit button is clicked
- (IBAction)submitButtonClicked:(id)sender;

// delegation method, refer to the method in Connection class
- (void) isUploadSuccessful : (BOOL)upload;
@end