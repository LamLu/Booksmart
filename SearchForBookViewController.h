//
//  SearchForBookViewController.h
//  Booksmart
//
//  Created by Thanh Au on 6/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBookConnection.h"

@interface SearchForBookViewController : UIViewController <WsCompleteSearchForBookConnectionDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSArray *listOfBook;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchResult;
@end
