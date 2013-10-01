//
//  EditProfileConnection.h
//  Booksmart
//
//  Created by Thanh Au on 9/18/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTSingleton.h"
@protocol WsCompleteEditProfileDelegate

-(void) isEditProfileSuccessful :(BOOL)editSuccess handleError:(NSString *) errorMessage;
@end
@interface EditProfileConnection : NSObject
{
    NSDictionary * jsonObject;
    NSString * errorString;
}
@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) UIAlertView *loadingAlertView;
@property (retain, nonatomic) id <WsCompleteEditProfileDelegate> delegate;
/*
 * method to connect to database to login
 * @param email is the email to login
 * @param description is the description to login
 * @param firstName is the user first name
 * @param lastName is the user last name
 * @param schools is the user school name
 * @param image is the user image
 */
-(void)createConnection:(NSString *) email description:(NSString *)description firstName:(NSString *)firstName lastName:(NSString *)lastName school:(NSString *)school image:(UIImage *) image ;

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


