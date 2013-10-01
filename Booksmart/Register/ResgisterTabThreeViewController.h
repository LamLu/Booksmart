//
//  ResgisterTabThreeViewController.h
//  Booksmart
//
//  Created by Lam Lu on 8/7/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "RegisterConnection.h"

@interface ResgisterTabThreeViewController : UIViewController <WsCompleteRegisterDelegate>
@property (retain, nonatomic) NSString * firstname;
@property (retain, nonatomic) NSString * lastname;
@property (retain, nonatomic) NSString * email;
@property (retain, nonatomic) NSString * password;

@property (weak, nonatomic) IBOutlet CustomTextField *schoolTextField;
@property (nonatomic, retain) KeychainItemWrapper* keychainItem;

- (IBAction) textFieldFinishedWithKeyBoard:(id)sender;
- (IBAction)textFieldDidBeginEditing:(id) sender;
- (IBAction)nextButtonClicked:(id)sender;
@end
