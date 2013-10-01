//
//  InventoryViewController.h
//  Booksmart
//
//  Created by Lam Lu on 7/15/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InventoryConnection.h"
#import "WTTSingleton.h"
#import "Book.h"
#import "DisplayBookInfoViewController.h"
#import "BookTableViewCell.h"
#import "DeleteBookConnection.h"

@interface InventoryViewController : UITableViewController<ProcessAfterGettingInventory>
{
    NSString *email;
}
@property (nonatomic, retain) NSMutableArray *bookArray;

//@param aBool : Yes = success, No = fail
//@param bookArray the array of the books
- (void) isRetrievingSuccessful : (BOOL) aBool bookArray: (NSArray*) array ;
- (void)populateView:(NSString*)otherEmail;
@end
