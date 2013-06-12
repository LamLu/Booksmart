//
//  SearchViewController.h
//  Booksmart
//
//  Created by test on 6/10/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"


@interface SearchViewController : UIViewController <WsCompleteDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSArray *listOfUser;
    NSString *selectSegment;
    
}
@property (weak, nonatomic) IBOutlet UITableView *searchResult;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeOfSegment;
- (IBAction)changeSeg:(id)sender;



@end
