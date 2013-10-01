//
//  MessageMainScreenViewController.h
//  Booksmart
//
//  Created by Lam Lu on 8/1/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTTSingleton.h"
#import "SendMessageConnection.h"
#import "GetConversationConnection.h"

@interface MessageMainScreenViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,
WsCompleteGetConversationConnection,WsCompleteSentMessageConnectionDelegate,UITextFieldDelegate>
{
    NSMutableDictionary * jsonObject;
    NSArray *conversationArr;
}

@property (weak, nonatomic) IBOutlet UITextField *textBoxField;
@property (weak, nonatomic) IBOutlet UIView *sendMessageBoxView;
@property (weak, nonatomic) NSString * email;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)sendButtonClicked:(id)sender;

//populate other email when segue performed
- (void) populateView:(NSString *)emailOther;
// dismiss the keyboard when return button is hit
- (IBAction) textFieldFinishedWithKeyBoard:(id)sender;
@end
