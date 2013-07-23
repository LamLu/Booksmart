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
    NSString *email;

}



@property (nonatomic, retain) IBOutlet UITextField *textBoxField;
@property (nonatomic, strong) NSString* otherEmail;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction) clickSendButton;
- (IBAction) textFieldFinishedWithKeyBoard:(id)sender;
- (void) populateView:(NSString *)emailOther;
@end
