//
//  UploadOptionViewController.h
//  Booksmart
//
//  Created by Lam Lu on 7/31/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kUploadToInventory @"uploadToInventory"
#define kUploadToWishlist @"uploadToWishlist"


@interface UploadOptionViewController : UIViewController
- (IBAction)uploadToInventoryButtonClicked:(id)sender;
- (IBAction)uploadToWishlistButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;
@end
