//
//  UploadBookConnection.m
//  Booksmart
//
//  Created by Lam Lu on 6/26/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "UploadBookConnection.h"
#define MAX_IMAGE_SIZE 500000
@implementation UploadBookConnection
@synthesize receivedData;
@synthesize loadingAlertView;


/*
 * method to create Connection.
 * @param email the string email of the user
 * @param bookTitle the string title
 * @param bookEdition the string edition
 * @param bookISBN10 the string isbn10
 * @param bookISBN13 the string isbn13
 * @param bookPubisher the string publisher
 * @param bookAuthors the string of authors, separate by commas
 * @param bookSubject the string subject
 */
- (void)createConnection: (NSString *) email title: (NSString *) bookTitle edition: (NSString *) bookEdition isbn10: (NSString *) bookISBN10 isbn13: (NSString *) bookISBN13 publisher : (NSString *) bookPublisher authors: (NSString *) bookAuthors subject: (NSString *) bookSubject imageArray:(NSMutableArray *) imgArr;
{    
    
    NSString* link = [NSString stringWithFormat:@"%@%@", [WTTSingleton sharedManager].serverURL, @"/include_php/insertBook.php"];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                     requestWithURL:[NSURL URLWithString: link]
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                     timeoutInterval:15.0];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPShouldHandleCookies:NO];
    NSString *boundary = [NSString stringWithFormat:@"%@", @"--------------------asdaT0912380NCZCASDqweQOUOIASDz"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [theRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //body of HTTP Post
    NSMutableData *body = [NSMutableData data];
    
    //NSString *myParameters = [NSString stringWithFormat: @"email=%@&title=%@&edition=%@&isbn10=%@ &isbn13=%@&publisher=%@&subject=%@&authors=%@",
   //                           email, bookTitle, bookEdition, bookISBN10, bookISBN13, bookPublisher,bookSubject, bookAuthors];
    
    //add params to HTTP Post body
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email forKey:@"email"];
    if (bookTitle != nil)
        [params setObject:bookTitle forKey:@"title"];
    if (bookEdition != nil)
        [params setObject:bookEdition forKey:@"edition"];
    if (bookISBN10 != nil)
        [params setObject:bookISBN10 forKey:@"isbn10"];
    if (bookISBN13 != nil)
        [params setObject:bookISBN13 forKey:@"isbn13"];
    if (bookPublisher != nil)
        [params setObject:bookPublisher forKey:@"publisher"];
    if (bookSubject != nil)
        [params setObject:bookSubject forKey:@"subject"];
    if (bookAuthors != nil)
        [params setObject:bookAuthors forKey:@"authors"];
    
    for (NSString *param in params)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    int i = 0;
    for (UIImage *image in imgArr)
    {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    
        //if image size > 500kb compress it
        if ([imageData length] > MAX_IMAGE_SIZE)
        {
            CGFloat compressionRate = (MAX_IMAGE_SIZE) / [imageData length];
            imageData = UIImageJPEGRepresentation(image, compressionRate);
        }

        if (imageData)
        {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            NSString * imageName = [NSString stringWithFormat:@"%@%d", @"uploadedImg",i++];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"%@.jpg\"\r\n", imageName, imageName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
        
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        //imageData = nil;
    }
    [theRequest setHTTPBody:body];
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    
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
    boundary = nil;
    link = nil;
    body = nil;
    params = nil;
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
    NSString * result = [self parseJSON:receivedData];
    
    connection = nil;
    receivedData = nil;
    
     [self dismissLoadingAlertView];
    if (result == (id) [NSNull null])
    {
       
        [[self delegate] isUploadSuccessful:YES];
    }
    else
    {
        [[self delegate] isUploadSuccessful:NO];
    }
    
}

/*
 * This function is to parse JSON object get back from php
 * JSON should be in the format {"login"=>"passed"} or
 * {"login":"failed"}
 * @param : data the NSData get back from web services
 * @return: the string parsed or failed if parse error
 */
- (NSString *) parseJSON: (NSData *) data 
{
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:
                          NSJSONReadingMutableContainers error:&error];
    NSString *result = nil;
    if (json != nil)
        result = [json objectForKey:@"error"];
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
