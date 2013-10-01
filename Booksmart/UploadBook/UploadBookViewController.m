//
//  UploadBookViewController.m
//  Booksmart
//
//  Created by Lam Lu on 6/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "UploadBookViewController.h"

@interface UploadBookViewController ()

@end

@implementation UploadBookViewController
@synthesize bookCoverImageView, bookInfoTextField;
@synthesize cameraVC, resultAlertView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    bookInfoOutput = [[NSString alloc] init];
    bookTitle = [[NSString alloc] init];
    bookEdition = [[NSString alloc] init];
    bookPublisher = [[NSString alloc] init];
    bookAuthors = [[NSMutableString alloc] init];
    bookSubject = [[NSString alloc] init];
    bookISBN10 = [[NSString alloc] init];
    bookISBN13 = [[NSString alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayImage) name:kFinishCapturePhoto object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadToInventory) name:kUploadToInventory object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadToWishList) name:kUploadToWishlist object:nil];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    UIImage *image = [UIImage imageNamed:@"upload_header.png"];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    //navBar.tintColor = [UIColor yellowColor];
    [navBar setContentMode:UIViewContentModeScaleAspectFit];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsLandscapePhone];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBookCoverImageView:nil];
    [self setBookInfoTextField:nil];
    bookInfoOutput = nil;
    bookInfoOutput = nil;
    bookTitle = nil;
    bookEdition = nil;
    bookPublisher = nil;
    bookAuthors = nil;
    bookSubject = nil;
    bookISBN10 = nil;
    bookISBN13 = nil;
    [self setThumbnail1:nil];
    [self setThumbnail2:nil];
    [super viewDidUnload];
}
- (IBAction)barcodeScanButtonClicked:(id)sender {
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
   
    [self presentViewController:reader animated:YES completion:NULL];
    
    
}


- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    
    // EXAMPLE: do something useful with the barcode image
    // resultImage.image =
    // [info objectForKey: UIImagePickerControllerOriginalImage];
    
    
    NSString * isbnString = symbol.data;
    bookInfoOutput = [self parseBookJSON:[self getBookJSONFromISBN: isbnString]];
    bookInfoTextField.text = bookInfoOutput;
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissViewControllerAnimated:YES completion:NULL];
    bookInfoOutput = nil;
    
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

/*
 Get book json object from isbn
 @param isbn: the barcode scanned from the camera
 @return the dictionary of json object
 */
- (NSDictionary*) getBookJSONFromISBN: (NSString *) isbn
{
    /****
     IMPORTANT: CHECK FOR INTERNET CONNECTION FIRST
     */
    
    NSString * url = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=isbn:%@&key=AIzaSyDy8k0Bz1C9fPy1xw_HGQT64I2vAQZUPe0", isbn];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError = nil;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:response1 options:
                          NSJSONReadingMutableContainers error:&requestError];
    
    
    return json;
}

/*
 * parse the book json object 
 * @param bookJSON : the dictionary of json object of the book from scanning
 * @return a formatted book info to populate the bookInfoTextField
 */
- (NSString *) parseBookJSON: (NSDictionary*) bookInfo
{
    if (bookInfo == nil)
        return nil;
    
	// Do any additional setup after loading the view.
    
    NSDictionary * book = [[NSDictionary alloc] init];
    if ([bookInfo objectForKey:@"totalItems"] > 0)
    {
        NSArray * items = (NSArray *)[bookInfo objectForKey:@"items"];
        book = [items objectAtIndex:0];
        items = nil;
    }
    NSMutableString * stringOutput = [[NSMutableString alloc] init];
    
    //get title of the book
    NSDictionary *volumeInfo = [[NSDictionary alloc]init];
    volumeInfo = [book objectForKey:@"volumeInfo"];
    bookTitle =  [volumeInfo objectForKey:@"title"];
    stringOutput = [NSMutableString stringWithFormat:@"Title : %@", bookTitle];
    
    //get author
    NSArray* author = (NSArray *) [volumeInfo objectForKey:@"authors"];
    stringOutput = [NSMutableString stringWithFormat:@"%@ \nAuthor(s): ", stringOutput];
    for (int i = 0; i < [author count]; i++)
    {
        if (i < [author count] - 1)
            bookAuthors = [NSMutableString stringWithFormat:@"%@ %@, ", bookAuthors, [author objectAtIndex:i]];
        else
            bookAuthors = [NSMutableString stringWithFormat:@"%@ %@", bookAuthors, [author objectAtIndex:i]];
    }
    
    NSLog (@"%@", bookAuthors);
    stringOutput = [NSMutableString stringWithFormat:@"%@ %@", stringOutput, bookAuthors];
    
    //get isbn item
    NSArray*isbnItem = [[NSArray alloc] init];
    isbnItem = (NSArray*)[volumeInfo objectForKey:@"industryIdentifiers"];
    
    //get isbn 10
    bookISBN10 = [(NSDictionary *)[isbnItem objectAtIndex:0] objectForKey:@"identifier"];
    stringOutput = [NSMutableString stringWithFormat:@"%@ \nISBN 10: %@", stringOutput, bookISBN10];
    
    //get isbn 13
    bookISBN13 = [(NSDictionary *)[isbnItem objectAtIndex:1] objectForKey:@"identifier"];

    stringOutput = [NSMutableString stringWithFormat:@"%@ \nISBN 13: %@", stringOutput,bookISBN13];
    
    //get book publisher
    bookPublisher =  [volumeInfo objectForKey:@"publisher"];
    stringOutput = [NSMutableString stringWithFormat:@"%@ \nPublisher: %@", stringOutput,bookPublisher];
    
    //get book cover image
    NSString * imagelink = [(NSDictionary *)[volumeInfo objectForKey:@"imageLinks"] objectForKey:@"thumbnail"];
    bookCoverImageView.image = [self getImageFromURL:imagelink];
    
    //clean up memory
    volumeInfo = nil;
    imagelink = nil;
    book = nil;
    isbnItem = nil;
    return stringOutput;
}

/**
 * get image from url.
 * @param: url the url string to download the image
 */

- (UIImage *) getImageFromURL : (NSString *) url
{
    // NSLog (@"%@", url);
    NSURL *imageURL = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    //testing
    //NSData *imgData = UIImageJPEGRepresentation(image, 0);
    //NSLog(@"Size of Image(bytes):%d",[imgData length]);
    
    return image ;
}

/**
 * upload book to inventory
 */

- (void) uploadToInventory
{
  
    
    UploadBookConnection * connection = [[UploadBookConnection alloc] init];
    bookSubject = @"Test Subject";
    [connection setDelegate:self];
    [connection createConnection:[WTTSingleton sharedManager].userprofile.email title:bookTitle edition:bookEdition isbn10:bookISBN10 isbn13:bookISBN13 publisher:bookPublisher authors:bookAuthors subject:bookSubject imageArray:imgArr isWishList:FALSE];

}

/**
 * upload to wishlist
 */
- (void) uploadToWishList
{

    UploadBookConnection * connection = [[UploadBookConnection alloc] init];
    bookSubject = @"Test Subject";
    [connection setDelegate:self];
    [connection createConnection:[WTTSingleton sharedManager].userprofile.email title:bookTitle edition:bookEdition isbn10:bookISBN10 isbn13:bookISBN13 publisher:bookPublisher authors:bookAuthors subject:bookSubject imageArray:imgArr isWishList:TRUE];
     
}

// delegation method, refer to the method in Connection class

- (void) isUploadSuccessful:(BOOL)upload
{
    if(upload == YES)
    {
        [self displayResultAlertView: @"Uploaded Book Successfully"];
    }
    
    else if (upload == NO)
    {
        [self displayResultAlertView: @"Error uploading book. Please try again"];
    }
}


- (void) displayResultAlertView : (NSString *) message
{
   
    resultAlertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [resultAlertView show];
    
}



- (IBAction)cameraButtonClicked:(id)sender
{
    //UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhoneTest" bundle:nil];
    cameraVC = (CustomCameraViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CustomCamera"];
    //[self presentModalViewController:cameraVC animated:YES completion:nil];
    [self presentViewController:cameraVC animated:YES completion:nil];
    

    
}

/**
 * display the images on thumbnail when photo have been taken
 */
- (void) displayImage
{
    int count = [cameraVC.imageArray count];
    if (count == 1)
        self.thumbnail1.image = [cameraVC.imageArray objectAtIndex:0];
    else if (count == 2)
    {
        self.thumbnail1.image = [cameraVC.imageArray objectAtIndex:0];
        self.thumbnail2.image = [cameraVC.imageArray objectAtIndex:1];
    }
    imgArr = cameraVC.imageArray;
}

- (IBAction)submitButtonClicked:(id)sender
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UploadOptionViewController * uploadOptionVC = [storyboard instantiateViewControllerWithIdentifier:@"uploadOptionVC"];
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentModalViewController:uploadOptionVC animated:NO];
    uploadOptionVC.view.frame = CGRectMake(0, self.view.window.frame.size.height, uploadOptionVC.view.frame.size.width, uploadOptionVC.view.frame.size.height);
    
    [UIView animateWithDuration:0.5 animations:^
    {
        uploadOptionVC.view.frame = CGRectMake(0, 0 + [UIApplication sharedApplication].statusBarFrame.size.height, uploadOptionVC.view.frame.size.width, uploadOptionVC.view.frame.size.height);
    }];
}
@end
