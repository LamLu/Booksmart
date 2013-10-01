//
//  InboxViewController.h
//  Booksmart
//
//  Created by Thanh Au on 7/16/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InboxConnection.h"
#import "MessageMainScreenViewController.h"


@interface InboxViewController : UITableViewController<WsCompleteGetInboxConnection>
{
    NSArray *emailOther;
}
@end
