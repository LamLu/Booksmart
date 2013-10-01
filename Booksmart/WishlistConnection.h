//
//  WishlistConnection.h
//  Booksmart
//
//  Created by Thanh Au on 8/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTSingleton.h"
#import "Book.h"
@protocol ProcessAfterGettingWishlist <NSObject>

@required
//@param aBool : Yes = success, No = fail
//@param bookArray the array of the books
- (void) isRetrievingSuccessful : (BOOL) aBool bookArray: (NSArray*) array ;

@end

@interface WishlistConnection : NSObject
{
    NSMutableDictionary * jsonObject;
}
@property (nonatomic,retain) id <ProcessAfterGettingWishlist> delegate;
@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) UIAlertView *loadingAlertView;


/*
 * method to connect to database to get the book inventory
 * @param email the email of the user
 */
-(void) createConnection : (NSString*) message;

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
