//
//  MessageViewController.h
//  Message
//
//  Created by Lam Lu on 5/28/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTTSingleton.h"
#import "SendMessageConnection.h"
#import "GetConversationConnection.h"



@interface MessageViewController : UITableViewController<WsCompleteGetConversationConnection,WsCompleteSentMessageConnectionDelegate>
{
    NSMutableDictionary * jsonObject;
    NSArray *conversationArr;
    UIButton* sendButton;

}


@property (nonatomic, strong) NSString* otherEmail;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) IBOutlet UITableView *tableView;


- (void) clickSendButton;

@end
