//
//  MatchingBookViewController.h
//  Booksmart
//
//  Created by Thanh Au on 8/22/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WishlistConnection.h"
#import "WTTSingleton.h"
#import "Book.h"
#import "LIstOfSellerViewController.h"
@interface MatchingBookViewController : UITableViewController<ProcessAfterGettingWishlist>
@property (nonatomic, retain) NSMutableArray *bookArray;

//@param aBool : Yes = success, No = fail
//@param bookArray the array of the books
- (void) isRetrievingSuccessful : (BOOL) aBool bookArray: (NSArray*) array ;

@end
