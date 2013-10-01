//
//  DeleteBookConnection.h
//  Booksmart
//
//  Created by Thanh Au on 8/22/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTSingleton.h"
#import "Book.h"

@protocol ProcessAfterDeleteBook <NSObject>

@required
//@param aBool : Yes = success, No = fail
//@param bookArray the array of the books
- (void) isDeleteSuccessful : (BOOL) aBool;

@end
@interface DeleteBookConnection : NSObject
{
    NSMutableDictionary * jsonObject;
}
@property (nonatomic,retain) id <ProcessAfterDeleteBook> delegate;
@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) UIAlertView *loadingAlertView;


/*
 * method to create Connection.
 * @param bookId is id book
 * @param isWishlist is to determine to delete in user_book or user_wishlist
 */
-(void) createConnection : (int) bookId isWishlist:(NSString*)isWishlist;

/*
 * display the loading AlertView
 */
- (void) displayLoadingAlertView;

/*
 * dimiss the loading alerView
 */
- (void) dismissLoadingAlertView;


/*
 * This function is to parse JSON object get back from php
 * @return an array if succesfully parseJSON, nil otherwise
 */
- (NSArray *) parseJSON: (NSData *) data ;

@end
