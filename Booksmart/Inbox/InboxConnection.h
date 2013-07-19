//
//  InboxConnection.h
//  Booksmart
//
//  Created by Thanh Au on 7/16/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTSingleton.h"
@protocol WsCompleteGetInboxConnection
-(void) finished;
@end
@interface InboxConnection : NSObject
{
    NSDictionary * jsonObject;
    NSMutableArray * jsonArr;
}
@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) UIAlertView *loadingAlertView;
@property (retain, nonatomic) id <WsCompleteGetInboxConnection> delegate;
/*
 * method to connect to database to login
 * @param username is the username to login
 * @param password is the password to login
 */
-(void)createConnection:(NSString *) email;

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
