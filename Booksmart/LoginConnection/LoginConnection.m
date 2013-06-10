//
//  Connection.m
//  Login
//  This class is to establish the connection and process
//  data between iOS and web services
//  Created by Lam Lu on 2/24/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//  Link to apple document
//


#import "LoginConnection.h"

@implementation LoginConnection

@synthesize receivedData;
@synthesize delegate;
@synthesize loadingAlertView;

//initialize
- (id) init
{
    if (self = [super init])
    {
    }
    return self;
}


/*
 * method to create Connection.
 * @param username is the username to login
 * @param password is the password to login
 */
- (void)createConnection: (NSString *) username : (NSString *)password
{
    NSString* link = [NSString stringWithFormat:@"%@%@", [WTTSingleton sharedManager].serverURL, @"/include_php/loginData.php"];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                     requestWithURL:[NSURL URLWithString: link]
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                     timeoutInterval:15.0];
    
    NSString *myParameters = [NSString stringWithFormat: @"username=%@ & password=%@",
                              username, password];
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

- (void) displayLoadingAlertView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    loadingAlertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [loadingAlertView addSubview:progress];
    [progress startAnimating];
    [loadingAlertView show];
    progress = nil;
    
}

- (void) dismissLoadingAlertView
{
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   [loadingAlertView dismissWithClickedButtonIndex:0 animated:YES];
   loadingAlertView = nil;
}
/*
 * This message can be sent due to server redirects, or in rare cases multi-part MIME documents.
 * Each time the delegate receives the connection:didReceiveResponse: message, it should reset and
 * progress indication and discard all previously received data
 */

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}



/*
 * The delegate is periodically sent connection:didReceiveData: messages as the data is received.
 * The delegate implementation is responsible for storing the newly received data
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}


/*
 * If an error is encountered during the download, the delegate receives a
 * connection:didFailWithError:message.
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    connection = nil;
    // receivedData is declared as a method instance elsewhere
    receivedData = nil;
    
    // inform the user
    // this is for debugging. should hide from user
    //NSLog(@"Connection failed! Error - %@ %@",
    //      [error localizedDescription],
    //      [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    [self dismissLoadingAlertView];
    
    NSLog(@"%@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed"
                                                    message:@"Could not connect to server! Check Your Network Connection" delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    alert = nil; //release arlet when done
    error = nil;
    
}


/*
 * If the connection succeeds in downloading the request, the delegate receives
 * the connectionDidFinishLoading: message. The delegate will receive no further
 * messages for the connection and the NSURLConnection object can be released.
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    NSString * result = [self parseJSON:receivedData];
    
    // release the connection, and the data object
    connection = nil;
    receivedData = nil;
    [self dismissLoadingAlertView];
    
    if([result caseInsensitiveCompare:@"failed"] == NSOrderedSame)
    {
        result = nil;
        jsonObject = nil;
        [[self delegate] isLogInSuccessful:NO];
    }
    
    
    else if([result caseInsensitiveCompare:@"passed"] == NSOrderedSame)
    {
        NSString * firstname = nil;
        NSString * lastname = nil;
        NSString * email = nil;
        NSString * school = nil;
        NSString * major = nil;
        UIImage  * image = nil;
        
        
       // if ([jsonObject objectForKey:@"userFirstName"] != [NSNull null])                                                           firstname = [jsonObject objectForKey:@"userFirstName"];
        
     //   if ([jsonObject objectForKey:@"userLastName"] != [NSNull null])
            lastname = [jsonObject objectForKey:@"userLastName"];
        
     //   if ([jsonObject objectForKey:@"userEmail"] != [NSNull null])
            email = [jsonObject objectForKey:@"userEmail"];
        
     //   if ([jsonObject objectForKey:@"userSchool"] != [NSNull null])
            school = [jsonObject objectForKey:@"userSchool"];

     //   if ([jsonObject objectForKey:@"userMajor"] != [NSNull null])
            major = [jsonObject objectForKey:@"userMajor"];
        
 
        
        if ([jsonObject objectForKey:@"userProfileImgSrc"] != [NSNull null])
        {
            NSError * err = nil;
            NSString * imageURL = [NSString stringWithFormat:@"%@%@", [WTTSingleton sharedManager].serverURL, [jsonObject objectForKey:@"userProfileImgSrc"]];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: imageURL] options:NSDataReadingUncached error:&err];
            if(err)
            {
                NSLog(@"ERROR IN LOGIN CONNECTION  %@", err);
                return;
            }                                                        
            image = [UIImage imageWithData:data];
            imageURL = nil;
        }
    
           
        [[WTTSingleton sharedManager].userprofile setUserProfile:image setUserFirstName:firstname setUserLastName:lastname setEmail:email setSchool:school setMajor:major];
        
        jsonObject = nil;
        
        [[self delegate] isLogInSuccessful:YES];
    }
    
}

/*
 * This function is to parse JSON object get back from php
 * JSON should be in the format {"login"=>"passed"} or
 * {"login":"failed"}
 * @param : data the NSData get back from web services
 * @return: the string parsed or failed if parse error
 */
- (NSString *) parseJSON: (NSData *) data ;
{
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:
                          NSJSONReadingMutableContainers error:&error];
    NSString *result = nil;
    //error parsing
    if(!json)
    {
        NSLog(@"%@", error);
        result = @"failed";
    }
    else
    {
        result =  (NSString*)[json objectForKey:@"login"];
        jsonObject= [json objectForKey:@"userProfile"];
    }
    
    json = nil;
    error = nil;
    return result;
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSArray * trustedHosts = [NSArray arrayWithObjects:@"srv01.hidevmobile.com", nil];
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([trustedHosts containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
@end
