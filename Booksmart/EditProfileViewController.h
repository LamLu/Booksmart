//
//  EditProfileViewController.h
//  Booksmart
//
//  Created by Thanh Au on 9/18/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "WTTSingleton.h"
@interface EditProfileViewController : UIViewController <UIActionSheetDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIAlertViewDelegate>

{
    
    NSString *userFirstName;
    NSString *userLastName;
    NSString *userDescription;
    NSString *userSchool;
    NSString *userEmail;
}
@property (weak, nonatomic) UIImage *imgUser;
@property (weak, nonatomic) IBOutlet CustomTextField *firstNameLabel;
@property (weak, nonatomic) IBOutlet CustomTextField *lastNameLabel;
@property (weak, nonatomic) IBOutlet CustomTextField *emailLabel;
@property (weak, nonatomic) IBOutlet CustomTextField *schoolLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
- (IBAction)editPicture:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imgButton;

- (IBAction)changePassword:(id)sender;
- (IBAction)cancle:(id)sender;
- (IBAction)done:(id)sender;


@end
