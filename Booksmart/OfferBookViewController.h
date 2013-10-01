//
//  OfferBookViewController.h
//  Booksmart
//
//  Created by Thanh Au on 7/25/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListOfTradingBookConnection.h"

@interface OfferBookViewController : UITableViewController<WsCompleteInventoryConnectionDelegate>
{
    NSArray *listOfBook;
}

- (IBAction)done:(id)sender;

@end
