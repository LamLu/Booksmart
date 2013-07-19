//
//  BookInfoViewController.h
//  Booksmart
//
//  Created by Thanh Au on 6/27/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIstOfSellerViewController.h"
#import "Book.h"

@interface BookInfoViewController : UIViewController
{
    UIImage *bookImage;
    NSString *titleBook;
    NSString *editionBook;
    NSMutableArray *authorBook;
    NSString *ISBNBook10;
    NSString *ISBNBook13;
    Book *_book;
}
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookEditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookISBN10Label;
@property (weak, nonatomic) IBOutlet UILabel *bookISBN13Label;

@property (weak, nonatomic) IBOutlet UILabel *bookAuthorLabel;

- (void)populateView:(UIImage*)image title:(NSString*) title edition: (NSString*) edition author:(NSMutableArray*) author ISBN10:(NSString*) ISBN10 ISBN13:(NSString*) ISBN13;
- (void)populateView:(Book*)book;
@end
