//
//  RegisterConnection.h
//  Booksmart
//
//  Created by Thanh Au on 9/14/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTSingleton.h"
@protocol WsCompleteRegisterDelegate

//@param login : Yes = success, No = fail
- (void) isRegisterSuccessful : (BOOL)registerSuccess handleError: (NSString *) errorMessage;
@end
@interface RegisterConnection : NSObject
{
    NSDictionary * jsonObject;
    NSString * errorString;
}
@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) UIAlertView *loadingAlertView;
@property (retain, nonatomic) id <WsCompleteRegisterDelegate> delegate;
/*
 * method to connect to database to login
 * @param email is the email to login
 * @param password is the password to login
 * @param firstName is the user first name
 * @param lastName is the user last name
 * @param schools is the user school name
 */
-(void)createConnection:(NSString *) email password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName school:(NSString *)school ;

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
