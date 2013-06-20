//
//  BookInfoViewController.m
//  Booksmart
//
//  Created by Lam Lu on 6/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "BookInfoViewController.h"

@interface BookInfoViewController ()

@end

@implementation BookInfoViewController
@synthesize bookInfo;
@synthesize bookCoverImageView,bookTitleTextField,editionTextField;
@synthesize isbn10TextField,isbn13TextField,authorTextField;

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
- (void)viewDidUnload {
    [self setBookCoverImageView:nil];
    [self setBookTitleTextField:nil];
    [self setAuthorTextField:nil];
    [self setEditionTextField:nil];
    [self setIsbn10TextField:nil];
    [self setIsbn13TextField:nil];
    [super viewDidUnload];
    bookInfo = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * populate the view when it appears
 */
-(void) viewWillAppear: (BOOL) animated
{
    if (bookInfo == nil)
        return;
    
    NSLog (@"book info at BookInfoVC: %@", bookInfo);
	// Do any additional setup after loading the view.

    NSDictionary * book = [[NSDictionary alloc] init];
    if ([bookInfo objectForKey:@"totalItems"] > 0)
    {
        NSArray * items = (NSArray *)[bookInfo objectForKey:@"items"];
        book = [items objectAtIndex:0];
        items = nil;
    }
    
    //get title of the book
    NSDictionary *volumeInfo = [[NSDictionary alloc]init];
    volumeInfo = [book objectForKey:@"volumeInfo"];
    bookTitleTextField.text = [volumeInfo objectForKey:@"title"];
    
    //get book cover image
    NSString * imagelink = [(NSDictionary *)[volumeInfo objectForKey:@"imageLinks"] objectForKey:@"thumbnail"];
    bookCoverImageView.image = [self getImageFromURL:imagelink];
    
    
    //get isbn item
    NSArray*isbnItem = [[NSArray alloc] init];
    isbnItem = (NSArray*)[volumeInfo objectForKey:@"industryIdentifiers"];
    
    //get isbn 10
    NSString* isbn10 = [(NSDictionary *)[isbnItem objectAtIndex:0] objectForKey:@"identifier"];
    isbn10TextField.text = isbn10;
    
    
    //get isbn 13
    NSString* isbn13 = [(NSDictionary *)[isbnItem objectAtIndex:1] objectForKey:@"identifier"];
    isbn13TextField.text = isbn13;
    volumeInfo = nil;
    imagelink = nil;
    book = nil;
    isbnItem = nil;
    isbn10 = nil;
    isbn13 = nil;
}

/**
 * get image from url.
 * @param: url the url string to download the image
 */

- (UIImage *) getImageFromURL : (NSString *) url
{
    NSLog (@"%@", url);
    NSURL *imageURL = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    //image = [self imageWithImage:image scaledToSize:CGSizeMake(200, 200)];
    
    //testing
    NSData *imgData = UIImageJPEGRepresentation(image, 0);
    NSLog(@"Size of Image(bytes):%d",[imgData length]);
    
    return image ;
}


- (void) setBookInfo : (NSDictionary *) info
{
    bookInfo = [[NSDictionary alloc] init];
    bookInfo = info;
}
@end
