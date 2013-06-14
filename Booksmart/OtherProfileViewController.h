//
//  OtherProfileViewController.h
//  Booksmart
//
//  Created by test on 6/12/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingPercentConnection.h"
@interface OtherProfileViewController : UIViewController<RatingPercentageConnectionCompleteDelegate>
{
    UIImage *img;
    NSString *userName;
    NSString *userDescription;
    NSString *userLocation;
    NSString *userSchool;
    NSString *userRating;
    NSString *userEmail;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *userSchoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRatingLabel;

- (IBAction)goToMessage:(id)sender;

- (IBAction)goToInventory:(id)sender;

- (IBAction)goToWishlist:(id)sender;


- (void)populateView:(UIImage*)image name:(NSString*) name description: (NSString*) description location: (NSString*) location school:(NSString*) school rating:(NSString*) rating;

- (void)populateView:(UIImage*)image name:(NSString*) name description: (NSString*) description location: (NSString*) location school:(NSString*) school email:(NSString*) email;
@end
