//
//  BookInfoViewController.m
//  Booksmart
//
//  Created by Thanh Au on 6/27/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "BookInfoViewController.h"

@interface BookInfoViewController ()

@end

@implementation BookInfoViewController

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
    UIImage *image = [UIImage imageNamed:@"book_info_header.png"];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    //navBar.tintColor = [UIColor yellowColor];
    [navBar setContentMode:UIViewContentModeScaleAspectFit];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsLandscapePhone];
    

	// Do any additional setup after loading the view.
    if (bookImage != nil)
        [self.bookImg setImage:bookImage];
    else
        [self.bookImg setImage:[UIImage imageNamed:@"book_default.png"]];
    [self.bookTitleLabel setText:titleBook];
    [self.bookISBN10Label setText:ISBNBook10];
    [self.bookISBN13Label setText:ISBNBook13];
    [self.bookEditionLabel setText:editionBook];
    //change this one
    //[self.bookAuthorLabel setText:authorBook];
    NSString *author = [[NSString alloc]init];
    for (int i = 0; i <[authorBook count]; i++) {
        if ([authorBook count] - 1 == i)
        {
            if (![[authorBook[i] objectForKey:@"name"] isEqual:@""])
                ;
            author = [author stringByAppendingString:[authorBook[i] objectForKey:@"name"]];
        }
        else
        {
            if (![[authorBook[i] objectForKey:@"name"] isEqual:@""])
                author = [author stringByAppendingFormat:@"%@,",[authorBook[i] objectForKey:@"name"]];
        }
    }

    [self.bookAuthorLabel setText:author];
    
    [self.bookISBN10Label setText:ISBNBook10];
    [self.bookISBN13Label setText:ISBNBook13];
    [self.bookEditionLabel setText:editionBook];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBookImg:nil];
    [self setBookTitleLabel:nil];
    [self setBookAuthorLabel:nil];
    [self setBookEditionLabel:nil];
    [self setBookISBN10Label:nil];
    [self setBookISBN13Label:nil];
    [super viewDidUnload];
}

- (void)populateView:(Book *)book
{
    _book = book;
    titleBook = [book bookTitle];
    editionBook = [book bookEdition];
    ISBNBook10 = [book bookISBN10];
        
    authorBook = [book bookAuthors];
    ISBNBook10 = [book bookISBN10];
    ISBNBook13 = [book bookISBN13];
    bookImage = [book bookImg1];
     
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ToListOfSeller"])
    {
        
        LIstOfSellerViewController *detailView = (LIstOfSellerViewController *)[segue destinationViewController];
        [detailView populateView:_book];
    }
}

@end
