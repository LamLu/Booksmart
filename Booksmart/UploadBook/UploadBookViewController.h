//
//  UploadBookViewController.h
//  Booksmart
//
//  Created by Lam Lu on 6/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "BookInfoViewController.h"

@interface UploadBookViewController : UIViewController <ZBarReaderDelegate>
{
    NSDictionary* bookInfo;
}

- (IBAction)barcodeScanButtonClicked:(id)sender;

@end
