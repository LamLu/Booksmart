//
//  InventoryViewController.h
//  Booksmart
//
//  Created by Dhruv on 6/13/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InventoryViewController : NSObject
@property (strong, nonatomic) UIWindow* window;

/*
 * method to connect to database to login
 * @param message The message that will be sent to the database
 * @param sender The sender of the message
 * @param receiver The receiver of the message
 */
-(void) createConnection : (NSString*) message :(NSString*) sender: (NSString* ) receiver;


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
 * JSON should be in the format {"login"=>"passed"} or
 * {"login":"failed"}
 * @param : data the NSData get back from web services
 * @return: the string parsed or failed if parse error
 */
- (NSString *) parseJSON: (NSData *) data ;


@end
