//
//  GetConversationConnection.m
//  Booksmart
//
//  Created by Thanh Au on 7/15/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "GetConversationConnection.h"

@implementation GetConversationConnection
@synthesize receivedData;
@synthesize loadingAlertView;
@synthesize delegate;
//initialize
- (id) init
{
    if (self = [super init])
    {
        jsonArr = [[NSMutableArray alloc] init];

    }
    return self;
}

-(void)createConnection:(NSString *) ownerEmail receiverEmail:(NSString *)receiverEmail 
{
    NSString* link = [NSString stringWithFormat:@"%@%@", [WTTSingleton sharedManager].serverURL, @"/include_php/getConversation.php"];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                     requestWithURL:[NSURL URLWithString: link]
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                     timeoutInterval:15.0];
    
    NSString *myParameters = [NSString stringWithFormat: @"ownerEmail=%@&receiverEmail=%@",ownerEmail,receiverEmail];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[myParameters dataUsingEncoding:NSUTF8StringEncoding]];
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
    if ([receivedData length] != 0)
    {
        NSString * result = [self parseJSON:receivedData];
        NSLog(@"%@", result);
        // release the connection, and the data object
        connection = nil;
        receivedData = nil;
        [self dismissLoadingAlertView];
        
        if([result caseInsensitiveCompare:@"failed"] == NSOrderedSame)
        {
            result = nil;
            jsonObject = nil;
            
           
        }
        
        
        else if([result caseInsensitiveCompare:@"passed"] == NSOrderedSame)
        {
            [WTTSingleton sharedManager].json = jsonArr;
            [delegate finishedGetConversation];
            result = nil;
            jsonObject = nil;
            
            
            
        }
    }
    else{
        [self dismissLoadingAlertView];
        
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
    NSString * temp = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",temp);
    
    //error parsing
    NSString *result = nil;
    NSLog(@"json = %@", json);
    if(!json)
    {
        //NSLog(@"errorr is %@", error);
        result = @"failed";
    }
    else
    {
        result =  @"passed";
        jsonObject = [json objectForKey:@"result"];
        for (id key in jsonObject)
        {
            NSDictionary *tempDict =[jsonObject objectForKey:key];
            [jsonArr addObject:tempDict];
        }
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
