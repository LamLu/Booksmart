//
//  HomeViewController.m
//  Booksmart
//
//  Created by Lam Lu on 7/30/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
- (void)viewDidAppear:(BOOL)animated
{
    UIImage *image = [UIImage imageNamed:@"home_header.png"];
    UIImage *backImage = [UIImage imageNamed:@"backbutton"];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    
    [navBar setContentMode:UIViewContentModeScaleAspectFit];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsLandscapePhone];
       
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
