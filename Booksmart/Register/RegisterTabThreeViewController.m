//
//  RegisterTabThreeViewController.m
//  Booksmart
//
//  Created by Lam Lu on 8/25/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "RegisterTabThreeViewController.h"

@interface RegisterTabThreeViewController ()

@end

@implementation RegisterTabThreeViewController
@synthesize firstname,lastname,email,password,school;

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
- (IBAction)nextButtonClicked:(id)sender
{
    
     NSLog (@"%@ %@ %@ %@", firstname, lastname, email, password);

}

/**
 * dismiss the keyboard, move view back to normal when keyboard dismissed
 */
- (IBAction) textFieldFinishedWithKeyBoard:(id)sender {
    [sender resignFirstResponder];
    CGPoint scrollPoint = CGPointMake(0.0, 0.0);
    [(UIScrollView*)self.view setContentOffset:scrollPoint animated:YES];
}

/**
 * Move label, textfields, and button when keyboard appear
 */
- (IBAction)textFieldDidBeginEditing:(id) sender
{
    
    CGPoint scrollPoint = CGPointMake(0.0, self.view.frame.size.height/3.5);
    [(UIScrollView*)self.view setContentOffset:scrollPoint animated:YES];
}



- (void)viewDidUnload {
    [self setSchoolTextField:nil];
    [super viewDidUnload];
}
@end
