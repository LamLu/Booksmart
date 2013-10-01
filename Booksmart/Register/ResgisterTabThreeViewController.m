//
//  ResgisterTabThreeViewController.m
//  Booksmart
//
//  Created by Lam Lu on 8/7/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "ResgisterTabThreeViewController.h"

@interface ResgisterTabThreeViewController ()

@end

@implementation ResgisterTabThreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)viewDidUnload
{
    [self setSchoolTextField:nil];
    [super viewDidUnload];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextButtonClicked:(id)sender {
    RegisterConnection *connection = [[RegisterConnection alloc]init];
    connection.delegate = self;
    [connection createConnection:self.email password:self.password firstName:self.firstname lastName:self.lastname school:self.schoolTextField.text];
    
}

/**
 * dismiss the keyboard, move view back to normal when keyboard dismissed
 */
- (IBAction) textFieldFinishedWithKeyBoard:(id)sender {
    [sender resignFirstResponder];
    //CGPoint scrollPoint = CGPointMake(0.0, 0.0);
    //[(UIScrollView*)self.view setContentOffset:scrollPoint animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    [textField resignFirstResponder];
    return YES;
}
- (void) isRegisterSuccessful : (BOOL)registerSuccess handleError: (NSString *) errorMessage
{
    if (registerSuccess == YES)
    {
        [[WTTSingleton sharedManager] storeUserCredentials:self.email storePassword:self.password];
        [[WTTSingleton sharedManager ]storeDefaultUserProfile:nil defaultName:[NSString stringWithFormat:@"%@ %@", self.firstname, self.lastname] defaultSchool:self.schoolTextField.text defaultMajor:@""];
        [self performSegueWithIdentifier:@"RegisterSuccess" sender:self];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register failed" message:errorMessage delegate:nil cancelButtonTitle:@"Try again" otherButtonTitles:nil           , nil];
        [alert show];
        alert = nil;
    }
}

//Dismisses Keyboard when anything but the text field is touched
- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    NSLog(@"keyboard");
    for (UIView* view in self.view.subviews) {
        NSLog(@"%@",[view class]);
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}
@end
