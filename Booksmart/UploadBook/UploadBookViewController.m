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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
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
    [self presentModalViewController: reader
                            animated: YES];
    

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
    bookInfo = [[NSDictionary alloc]init];
    bookInfo = [self getBookFromISBN: isbnString];

    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
    
    [self performSegueWithIdentifier:@"ScanSuccess" sender:self];
    
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

/*
    Get book from isbn
 */
- (NSDictionary*) getBookFromISBN: (NSString *) isbn
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
 * prepare the segue when scan screen is dismissed. this will populate the 
 * BookInfoViewController
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ScanSuccess"])
    {
        BookInfoViewController *biVC = segue.destinationViewController;
        [biVC setBookInfo:bookInfo];
    }
}

@end
