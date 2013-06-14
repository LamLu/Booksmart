//
//  InventoryConnection.m
//  Booksmart
//
//  Created by Dhruv on 6/14/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "InventoryConnection.h"

@implementation InventoryConnection

@synthesize loadingAlertView;
@synthesize receivedData;

/*
 * method to create Connection.
 * @param username is the username to login
 * @param password is the password to login
 */
- (void)createConnection: (NSString *)senderEmail
{
    NSString* link = [NSString stringWithFormat:@"%@%@", [WTTSingleton sharedManager].serverURL, @"/php/BookProcessor.php"];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                     requestWithURL:[NSURL URLWithString: link]
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                     timeoutInterval:15.0];
    
    NSString *myParameters = [NSString stringWithFormat: @"email=%@", senderEmail];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[myParameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    /*
     * Create the connection with the request and start loading the data. This is asynchronous request
     * If NSURLConnection can’t create a connection for the request, initWithRequest:delegate: returns
     * nil. If the connection is successful, an instance of NSMutableData is created to store the data
     * that is provided to the delegate incrementally.
     */
    
    //if the connection is still being connected after 1 second, load the indicator
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
    [self displayLoadingAlertView];
    if (connection) {
        
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
        
    } else
    {
        // Inform the user that the connection failed.
        NSLog(@"Connection Failed!");
    }
    
    
    theRequest = nil;
    myParameters = nil;
    link = nil;
    connection = nil;
}

@end
