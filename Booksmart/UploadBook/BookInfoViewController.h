//
//  BookInfoViewController.h
//  Booksmart
//
//  Created by Lam Lu on 6/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookInfoViewController : UIViewController
@property (nonatomic, retain) NSDictionary * bookInfo;

@property (weak, nonatomic) IBOutlet UIImageView *bookCoverImageView;
@property (weak, nonatomic) IBOutlet UITextField *bookTitleTextField;

@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *editionTextField;
@property (weak, nonatomic) IBOutlet UITextField *isbn10TextField;
@property (weak, nonatomic) IBOutlet UITextField *isbn13TextField;


/**
 * set the bookInfo dictionary when the segue is to be performed
 * @param info the dictionary to be set
 */
- (void) setBookInfo : (NSDictionary *) info;
@end
