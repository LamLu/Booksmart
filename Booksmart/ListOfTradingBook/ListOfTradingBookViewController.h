//
//  ListOfTradingBookViewController.h
//  Booksmart
//
//  Created by Thanh Au on 7/8/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListOfTradingBookConnection.h"

@interface ListOfTradingBookViewController : UITableViewController <WsCompleteInventoryConnectionDelegate, UITableViewDataSource,UITableViewDelegate>
{
    NSArray *listOfBook;
    NSString *userEmail;
}
- (void) populateView:email;
@end
