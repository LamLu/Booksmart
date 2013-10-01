//
//  DisplayBookInfoViewController.h
//  Booksmart
//
//  Created by Thanh Au on 8/19/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
@interface DisplayBookInfoViewController : UIViewController
{
    UIImage *bookImage;
   
    NSString *titleBook;
    NSString *editionBook;
    NSMutableArray *authorBook;
    NSString *ISBNBook10;
    NSString *ISBNBook13;
    NSString *professorBook;
    NSString *subjectBook;
    Book *_book;
    CGFloat animatedDistance;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
 @property (weak, nonatomic) IBOutlet UITextView *bookTitleLabel;
 @property (weak, nonatomic) IBOutlet UITextView *bookAuthorLabel;
 @property (weak, nonatomic) IBOutlet UITextField *bookEditionLabel;
 @property (weak, nonatomic) IBOutlet UITextField *bookISBN10Label;
 @property (weak, nonatomic) IBOutlet UITextField *bookISBN13Label;
 @property (weak, nonatomic) IBOutlet UITextField *bookSubjectLabel;
 @property (weak, nonatomic) IBOutlet UITextField *bookProfessorLabel;
- (IBAction)updateChange:(id)sender;
// dismiss the keyboard when return button is hit
- (IBAction) textFieldFinishedWithKeyBoard:(id)sender;
- (IBAction) textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction) textFieldDidEndEditing:(UITextField *)textField;
- (void)populateView:(Book*)book;
@end
