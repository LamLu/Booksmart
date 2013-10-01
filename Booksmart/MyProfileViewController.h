//
//  MyProfileViewController.h
//  Booksmart
//
//  Created by Thanh Au on 9/3/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageMainScreenViewController.h"
#import "InventoryViewController.h"
#import "WishlistViewController.h"
#import "BIDViewController.h"

@interface MyProfileViewController : UIViewController 
{
    UIImage *userImg;
    NSString *userName;
    NSString *userDescription;
    NSString *userLocation;
    NSString *userSchool;
    NSString *userRating;
    NSString *userEmail;
    Book *_book;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *userDescriptionLabel;


@property (weak, nonatomic) IBOutlet UILabel *userSchoolLabel;


@end
