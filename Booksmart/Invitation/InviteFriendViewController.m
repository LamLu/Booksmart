//
//  InviteFriendViewController.m
//  Booksmart
//
//  Created by Johnny on 9/24/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "InviteFriendViewController.h"
#import <MessageUI/MessageUI.h>

@interface InviteFriendViewController () <MFMessageComposeViewControllerDelegate>

- (IBAction)sendMessage:(id)sender;

@end

@implementation InviteFriendViewController

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

- (IBAction)sendMessage:(id)sender
{
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];

    messageVC.body = @"Hey! Check out our app that allows you to buy, sell and trade books. Go to http://hidevmobile.com/wordpress/ for more details.";
    messageVC.messageComposeDelegate = self;
    [self presentViewController:messageVC animated:NO completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    UIAlertView *status;
    switch (result)
    {
        case MessageComposeResultCancelled:
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case MessageComposeResultFailed:
            status = [[UIAlertView alloc]initWithTitle:@"Error" message:@"An unknown error occured while sending the message. Please try again." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [status show];
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case MessageComposeResultSent:
            status = [[UIAlertView alloc]initWithTitle:@"Successful" message:@"Your message was sent successfully. Thanks for telling your friends about Booksmart!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [status show];
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        default:
            break;
    }
}

@end
