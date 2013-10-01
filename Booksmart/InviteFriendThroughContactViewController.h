//
//  InviteFriendThroughContactViewController.h
//  Booksmart
//
//  Created by Thanh Au on 8/27/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface InviteFriendThroughContactViewController : UITableViewController
{
    NSArray *myContacts;
    ABAddressBookRef  *addressBook;
}
@end
