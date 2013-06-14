//
//  SearchViewController.h
//  Booksmart
//
//  Created by test on 6/10/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"

#import "OtherProfileViewController.h"


@interface SearchViewController : UIViewController <RatingPercentageConnectionCompleteDelegate,WsCompleteDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSArray *listOfUser;
    NSString *selectSegment;
    NSString *ratingPercentage;
    
}
@property (weak, nonatomic) IBOutlet UITableView *searchResult;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeOfSegment;
- (IBAction)changeSeg:(id)sender;



@end
