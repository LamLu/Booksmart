//
//  TradingProcessViewController.m
//  Booksmart
//
//  Created by Thanh Au on 7/23/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "TradingProcessViewController.h"

@interface TradingProcessViewController ()

@end

@implementation TradingProcessViewController

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

- (void)viewDidUnload {
    [self setLocation:nil];
    [self setTime:nil];
    [self setOfferItemTable:nil];
    [self setWantedItemTable:nil];
    [super viewDidUnload];
}
@end
