//
//  OtherProfileViewController.m
//  Booksmart
//
//  Created by test on 6/12/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "OtherProfileViewController.h"

@interface OtherProfileViewController ()

@end

@implementation OtherProfileViewController

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
    RatingPercentConnection *connection = [[RatingPercentConnection alloc]init];
    [connection createConnection:userEmail];
    connection.delegate = self;
	// Do any additional setup after loading the view.
    [self.userImage setImage:img];
    self.userNameLabel.text = userName;
    self.userDescriptionLabel.text = userDescription;
    self.userLocationLabel.text = userLocation;
    self.userSchoolLabel.text = userSchool;
    //self.userRatingLabel.text = userRating;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateView:(UIImage*)image name:(NSString*) name description: (NSString*) description location: (NSString*) location school:(NSString*) school rating:(NSString*) rating
{
    img = image;
    userName = name;
    userDescription = description;
    userLocation = location;
    userSchool = school;
    userRating = rating;
}
- (void)populateView:(UIImage*)image name:(NSString*) name description: (NSString*) description location: (NSString*) location school:(NSString*) school email:(NSString*) email
{
    img = image;
    userName = name;
    userDescription = description;
    userLocation = location;
    userSchool = school;
    userEmail = email;
}
- (void)viewDidUnload {
    img = nil;
    userName = nil;
    userDescription = nil;
    userLocation = nil;
    userSchool = nil;
    userRating = nil;

    [self setUserImage:nil];
    [self setUserNameLabel:nil];
    [self setUserDescriptionLabel:nil];
    [self setUserLocationLabel:nil];
    [self setUserSchoolLabel:nil];
    [self setUserRatingLabel:nil];

    [self setRatingButton:nil];
    [super viewDidUnload];
}
// Receive rating percentage of user from server
-(void) finishedRatingPercentageConnection
{
    
    userRating = [WTTSingleton sharedManager].ratingPercentage;
    self.userRatingLabel.text = userRating;
    if ([userRating isEqualToString: @"no rating"])
    {
        self.ratingButton.hidden = TRUE;
    }
}

// This will get called too before the view appears (when user click on a row)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ToRating"])
    {
        
        RatingViewController *detailView = (RatingViewController *)[segue destinationViewController];
        
        [detailView populateView:userEmail];
       
    }
}
@end
