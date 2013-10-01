//
//  RegisterViewController.m
//  Booksmart
//
//  Created by Lam Lu on 8/6/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
{
    //KBKeyboardHandler *keyboard;
}



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
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.confirmEmailTextField.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {

    [self setFirstNameTextField:nil];
    [self setLastNameTextField:nil];
    [self setEmailTextField:nil];
    [self setConfirmEmailTextField:nil];

    [super viewDidUnload];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(handleKeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(handleKeyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) viewDidDisAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void) handleKeyBoardWillShow:(NSNotification*) aNotification
{

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //NSLog(@"%f",kbSize.height);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;

    if (!CGRectContainsPoint(aRect, activeField.frame.origin)) {

        CGPoint scrollPoint = CGPointMake(0, activeField.frame.origin.y - kbSize.height + 60);
        

        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
     
}

- (void) handleKeyBoardWillHide:(NSNotification*) aNotification
{
    UIEdgeInsets contendInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contendInsets;
    self.scrollView.scrollIndicatorInsets = contendInsets;
    
}



//prepare the segue for tab 2

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromTab1ToTab2"])
    {
        NSLog(@"Test");
        // Get reference to the destination view controller
        RegisterTabTwoViewController *vc = [segue destinationViewController];
        
        vc.firstname = self.firstNameTextField.text;
        vc.lastname = self.lastNameTextField.text;
        vc.email = self.emailTextField.text;
        
        
    }
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
     
    // by default perform the segue transition
    if (![self.emailTextField.text isEqualToString:self.confirmEmailTextField.text]
        || self.emailTextField.text.length == 0
        || self.confirmEmailTextField.text.length == 0
        || self.lastNameTextField.text.length == 0
        || self.firstNameTextField.text.length == 0)
    {
        return NO;
    }
    return YES;
}
/*
 * Dissmis the keyboard when the return button is pressed
 * Connect this function to Did End on Exit of the text field from
 * storyboard
 * @param sender, the textfield responder
 */
- (IBAction)nextButtonClicked:(id)sender {
    
    if ([self.emailTextField.text isEqualToString:self.confirmEmailTextField.text]
        && self.emailTextField.text.length != 0
        && self.confirmEmailTextField.text.length != 0)
    {
        
        [self performSegueWithIdentifier:@"FromTab1ToTab2" sender:self];
    }
    else
    {
        NSString * errorString;
        
        
        
        
        if (![self.emailTextField.text isEqualToString:self.confirmEmailTextField.text])
        {
            errorString = @"Emails do not match!";
        }
        if (self.confirmEmailTextField.text.length == 0) {
            errorString = @"Please enter confirm email!";
        }
        if (![self stringIsValidEmail:self.emailTextField.text]) {
            errorString = @"Please enter correct email format!";
        }
        if (self.emailTextField.text.length == 0) {
            errorString = @"Please enter email!";
        }
        if (self.lastNameTextField.text.length == 0) {
            errorString = @"Please enter last name!";
        }
        if (self.firstNameTextField.text.length == 0) {
            errorString = @"Please enter first name!";
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    activeField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGPoint scrollPoint = CGPointMake(0, 0);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
    [textField resignFirstResponder];
    activeField = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    [textField resignFirstResponder];
    return YES;
}
-(BOOL) stringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @"+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
//Dismisses Keyboard when anything but the text field is touched
- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    NSLog(@"keyboard");
    for (UIView* view in self.scrollView.subviews) {
        NSLog(@"%@",[view class]);
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"keyboard");
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}
@end
