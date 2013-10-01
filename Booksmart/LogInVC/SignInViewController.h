//
//  SignInViewController.h
//  Want To Trade
//
//  Created by Lam Lu on 3/17/13.
//
//

#import <UIKit/UIKit.h>
#import "LoginConnection.h"
#import "WTTSingleton.h"

@interface SignInViewController : UIViewController<ProcessAfterLogin>

@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *pwField;



// delegation method, refer to the method in Connection class
// @param login : Yes = success, No = fail
@property (nonatomic, retain) KeychainItemWrapper* keychainItem;
- (void) isLogInSuccessful : (BOOL)login;

// dismiss the keyboard when return button is hit
- (IBAction) textFieldFinishedWithKeyBoard:(id)sender;

// action performed when signin button is click
- (IBAction) signInButtonClicked:(id)sender;
@end
