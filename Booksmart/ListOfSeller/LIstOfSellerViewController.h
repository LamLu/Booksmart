//
//  LIstOfSellerViewController.h
//  Booksmart
//
//  Created by Thanh Au on 6/27/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListOfSellerConnection.h"
#import "OtherProfileViewController.h"
#import "Book.h"

@interface LIstOfSellerViewController : UITableViewController<ListOfSellerConnectionCompleteDelegate, UITableViewDataSource,UITableViewDelegate>
{
    NSArray *listOfSeller;
    NSString *bookTitle;
    Book * _book;
}

-(void)populateView:(Book *) book;

@end
