//
//  SettingViewController.m
//  Booksmart
//
//  Created by Hi Dev Mobile on 6/19/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    UIImage *image = [UIImage imageNamed:@"setting_header.png"];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    //navBar.tintColor = [UIColor yellowColor];
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
