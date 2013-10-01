//
//  RegisterTabThreeViewController.h
//  Booksmart
//
//  Created by Lam Lu on 8/25/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface RegisterTabThreeViewController : UIViewController
@property (retain, nonatomic) NSString * firstname;
@property (retain, nonatomic) NSString * lastname;
@property (retain, nonatomic) NSString * email;
@property (retain, nonatomic) NSString * password;
@property (retain, nonatomic) NSString * school;
@property (weak, nonatomic) IBOutlet CustomTextField *schoolTextField;

- (IBAction) textFieldFinishedWithKeyBoard:(id)sender;
- (IBAction)textFieldDidBeginEditing:(id) sender;
- (IBAction)nextButtonClicked:(id)sender;

@end
