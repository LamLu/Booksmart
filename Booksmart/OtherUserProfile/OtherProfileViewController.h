//
//  OtherProfileViewController.h
//  Booksmart
//
//  Created by test on 6/12/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingPercentConnection.h"
#import "RatingViewController.h"
#import "ListOfTradingBookViewController.h"
#import "Book.h"
#import "MessageMainScreenViewController.h"
#import "InventoryViewController.h"
#import "WishlistViewController.h"
@interface OtherProfileViewController : UIViewController<RatingPercentageConnectionCompleteDelegate>
{
    UIImage *img;
    NSString *userName;
    NSString *userDescription;
    NSString *userLocation;
    NSString *userSchool;
    NSString *userRating;
    NSString *userEmail;
    Book *_book;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *userSchoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRatingLabel;
@property (weak, nonatomic) IBOutlet UIButton *ratingButton;





- (void)populateView:(UIImage*)image name:(NSString*) name description: (NSString*) description location: (NSString*) location school:(NSString*) school email:(NSString*) email;
- (void)populateView:(UIImage*)image name:(NSString*) name description: (NSString*) description location: (NSString*) location school:(NSString*) school email:(NSString*) email book:(Book *)book;

@end
