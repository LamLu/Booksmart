//
//  UploadOptionViewController.m
//  Booksmart
//
//  Created by Lam Lu on 7/31/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "UploadOptionViewController.h"

@interface UploadOptionViewController ()

@end

@implementation UploadOptionViewController

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

- (IBAction)uploadToInventoryButtonClicked:(id)sender
{

    [[NSNotificationCenter defaultCenter] postNotificationName:kUploadToInventory object:nil];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)uploadToWishlistButtonClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUploadToWishlist object:nil];
    [self dismissModalViewControllerAnimated:YES];
}


//cancel button is clicked
- (IBAction)cancelButtonClicked:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
