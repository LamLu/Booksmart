//
//  RegisterTabTwoViewController.m
//  Booksmart
//
//  Created by Lam Lu on 8/7/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "RegisterTabTwoViewController.h"

@interface RegisterTabTwoViewController ()

@end

@implementation RegisterTabTwoViewController
@synthesize firstname,lastname,email;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 * Dissmis the keyboard when the return button is pressed
 * Connect this function to Did End on Exit of the text field from
 * storyboard
 * @param sender, the textfield responder
 */
- (IBAction)nextButtonClicked:(id)sender {
    
    if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]
        && self.passwordTextField.text.length != 0
        && self.confirmPasswordTextField.text.length != 0)
    {
        [self performSegueWithIdentifier:@"FromTab2ToTab3" sender:self];
    }
    else
    {
        NSString * errorString;
        
        
        
        
        if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text])
        {
            errorString = @"Password do not match!";
        }
        if (self.confirmPasswordTextField.text.length == 0) {
            errorString = @"Please enter confirm password!";
        }
        
        if (self.passwordTextField.text.length == 0) {
            errorString = @"Please enter password!";
        }
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                          message:errorString
                                                         delegate:nil
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:nil , nil, nil];
        [message show];
        
    }
}

/**
 * dismiss the keyboard, move view back to normal when keyboard dismissed
 */
- (IBAction) textFieldFinishedWithKeyBoard:(id)sender {
    [sender resignFirstResponder];
    //CGPoint scrollPoint = CGPointMake(0.0, 0.0);
    //[(UIScrollView*)self.view setContentOffset:scrollPoint animated:YES];
}

/**
 * Move label, textfields, and button when keyboard appear
 */
- (IBAction)textFieldDidBeginEditing:(id) sender
{
    
    CGPoint scrollPoint = CGPointMake(0.0, self.view.frame.size.height/3.5);
    [(UIScrollView*)self.view setContentOffset:scrollPoint animated:YES];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    // by default perform the segue transition
    if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]
        || self.passwordTextField.text.length == 0
        || self.confirmPasswordTextField.text.length == 0)
    {
        return NO;
    }
    return YES;
}
//prepare the segue for tab 3

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"FromTab2ToTab3"])
    {
        
        // Get reference to the destination view controller
        RegisterTabThreeViewController *vc = [segue destinationViewController];
        
        vc.firstname = self.firstname;
        vc.lastname = self.lastname;
        vc.email = self.email;
        vc.password = self.passwordTextField.text;
        
        
    }
}
- (void)viewDidUnload {
    [self setPasswordTextField:nil];
    [self setConfirmPasswordTextField:nil];
    [super viewDidUnload];
}
@end
