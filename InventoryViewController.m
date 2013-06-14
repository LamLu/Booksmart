//
//  InventoryViewController.m
//  Booksmart
//
//  Created by Dhruv on 6/13/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "InventoryViewController.h"
#import "WTTSingleton.h"

@implementation InventoryViewController

/*
 * Creates connection to the database, and loads the book of the user who is signed in.
 * @param username is the username to login
 * @param password is the password to login
 */
- (void)createConnection: (NSString *) username : (NSString *)password
{
    
    NSString* receivedData = [NSMutableData data]; //check this line
    
    NSString* link = [NSString stringWithFormat:@"%@%@", [WTTSingleton sharedManager].serverURL, @"/php/BookProcessor.php"];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                     requestWithURL:[NSURL URLWithString: link]
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                     timeoutInterval:15.0];
    
    
    NSString *myParameters = [NSString stringWithFormat: @"sender=%@ & receiver=%@",
                              @"sample@sample.com", @"sample2@sample.com"];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[myParameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
    
    if (connection)
    {
        //Inform the user that the connection was successful
        NSLog(@"Connection successful");
    }
    
    else
    {
        
        // Inform the user that the connection failed.
        NSLog(@"Connection Failed!");
        
    }
    
    theRequest = nil;
    myParameters = nil;
    link = nil;
    connection = nil;
    
}

- (void) displayLoadingAlertView
{
    
    
}

- (void) dismissLoadingAlertView
{
    
}


@end
