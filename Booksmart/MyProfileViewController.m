//
//  MyProfileViewController.m
//  Booksmart
//
//  Created by Thanh Au on 9/3/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

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
	self.userDescriptionLabel.opaque = NO;
    self.userDescriptionLabel.backgroundColor = [UIColor clearColor];
    self.userDescriptionLabel.textColor = [UIColor whiteColor];

    if (userImg != nil) {
        [self.userImageView setImage:userImg];
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    userName = [user stringForKey:@"userName"];
    userSchool = [user stringForKey:@"userSchool"];
    self.userNameLabel.text = userName;
    self.userDescriptionLabel.text = userDescription;
    self.userSchoolLabel.text = userSchool;
}
- (void)viewDidAppear:(BOOL)animated
{
    UIImage *image = [UIImage imageNamed:@"my_profile_header.png"];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    //navBar.tintColor = [UIColor yellowColor];
    [navBar setContentMode:UIViewContentModeScaleAspectFit];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsLandscapePhone];
    
    if ([WTTSingleton sharedManager].userprofile.userimg != nil) {
        self.userImageView.image = [WTTSingleton sharedManager].userprofile.userimg;
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
