//
//  RatingViewController.h
//  Booksmart
//
//  Created by test on 6/14/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayRatingConnection.h"

@interface RatingViewController : UITableViewController
{
    NSString* userEmail;
}

-(void)populateView:(NSString *) email;
@end
