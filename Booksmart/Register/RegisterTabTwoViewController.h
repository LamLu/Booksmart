//
//  RegisterTabTwoViewController.h
//  Booksmart
//
//  Created by Lam Lu on 8/7/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "RegisterTabThreeViewController.h"

@interface RegisterTabTwoViewController : UIViewController
@property (retain, nonatomic) NSString * firstname;
@property (retain, nonatomic) NSString * lastname;
@property (retain, nonatomic) NSString * email;
@property (weak, nonatomic) IBOutlet CustomTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *confirmPasswordTextField;

- (IBAction) textFieldFinishedWithKeyBoard:(id)sender;
- (IBAction)textFieldDidBeginEditing:(id) sender;
- (IBAction)nextButtonClicked:(id)sender;
@end
