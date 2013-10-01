//
//  RegisterViewController.h
//  Booksmart
//
//  Created by Lam Lu on 8/6/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "KBKeyboardHandler.h"
#import "RegisterTabTwoViewController.h"
@interface RegisterViewController : UIViewController <UITextFieldDelegate>
{
    UITextField *activeField;
    BOOL keyboardShow;
    BOOL viewMoved;
    
}
@property (weak, nonatomic) IBOutlet CustomTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *emailTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *confirmEmailTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)nextButtonClicked:(id)sender;

- (IBAction) textFieldFinishedWithKeyBoard:(id)sender;

@end
