//
//  InventoryConnection.m
//  Booksmart
//
//  Created by Dhruv on 6/14/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "InventoryConnection.h"

@implementation InventoryConnection

@synthesize loadingAlertView,delegate;
@synthesize receivedData;

/*
 * method to create Connection.
 * @param username is the username to login
 * @param password is the password to login
 */
- (void)createConnection: (NSString *)email
{
    NSString* link = [NSString stringWithFormat:@"%@%@", [WTTSingleton sharedManager].serverURL, @"/include_php/getBookData.php"];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                     requestWithURL:[NSURL URLWithString: link]
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                     timeoutInterval:15.0];
    
    NSString *myParameters = [NSString stringWithFormat: @"email=%@", email];
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
    NSArray * resultArray = [self parseJSON:receivedData];
    
    connection = nil;
    receivedData = nil;
    
    
    NSMutableArray *bookArray = [[NSMutableArray alloc]init];
    //if success, populate the book object
    if (resultArray != nil)
    {
        for (NSDictionary * bookJSON in resultArray)
        {
            Book * book = [[Book alloc] init];
            book.bookId = (int) [bookJSON objectForKey:@"bookID"];
            book.bookTitle = (NSMutableString *) [bookJSON objectForKey:@"bookTitle"];
            book.bookEdition = (NSMutableString*) [bookJSON objectForKey:@"bookEdition"];
            book.bookAuthors = (NSMutableArray *) [bookJSON objectForKey:@"bookAuthors"];
            book.bookISBN10 = (NSMutableString *) [bookJSON objectForKey:@"bookISBN10"];
            book.bookISBN13 = (NSMutableString *) [bookJSON objectForKey:@"bookISBN13"];
            book.bookPublisher = (NSMutableString *) [bookJSON objectForKey:@"bookPublisher"];
            
            NSString * url = [NSString stringWithFormat:@"%@%@", [WTTSingleton sharedManager].serverURL, [bookJSON objectForKey:@"bookImgPath1"]];
            book.bookImg1 = [self getImageFromURL:url];
            url = nil;
            
            url = [NSString stringWithFormat:@"%@%@", [WTTSingleton sharedManager].serverURL, [bookJSON objectForKey:@"bookImgPath2"]];
            book.bookImg2 = [self getImageFromURL:url];
            url = nil;
            book.bookSubjects =(NSMutableArray *) [bookJSON objectForKey:@"bookSubjects"];
            [bookArray addObject:book];
            book = nil;
            
        }
        [self dismissLoadingAlertView];
        [[self delegate] isRetrievingSuccessful:YES bookArray:bookArray];
    }
    else
    {
        [self dismissLoadingAlertView];
        [[self delegate] isRetrievingSuccessful:NO bookArray:nil];
    }
     
    
}

/*
 * This function is to parse JSON object get back from php
 * @return: the string parsed or failed if parse error
 */
- (NSArray *) parseJSON: (NSData *) data
{
    NSError *error = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:
                          NSJSONReadingMutableContainers error:&error];
    error = nil;
    return json;
}


/*
 * get an image from the url
 * @return an uiimage if success, nil otherwise
 */
-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result = [[UIImage alloc] init];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    data = nil;
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
