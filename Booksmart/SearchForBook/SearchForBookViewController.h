//
//  SearchForBookViewController.h
//  Booksmart
//
//  Created by Thanh Au on 6/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBookConnection.h"
#import "BookInfoViewController.h"
#import "Book.h"

@interface SearchForBookViewController : UIViewController <WsCompleteSearchForBookConnectionDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSArray *listOfBook;
    NSString *_input;
    NSString *_scope;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchResult;
- (void)populateView:(NSString*)input scope:(NSString*) scope;
@end
