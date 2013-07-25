//
//  OfferMoneyViewController.m
//  Booksmart
//
//  Created by Thanh Au on 7/25/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "OfferMoneyViewController.h"

@interface OfferMoneyViewController ()

@end

@implementation OfferMoneyViewController

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

- (IBAction)done:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
