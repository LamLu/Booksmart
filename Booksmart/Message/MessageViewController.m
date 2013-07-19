//
//  MessageViewController.m
//  Message
//
//  Created by Lam Lu on 5/28/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "MessageViewController.h"



@interface MessageViewController ()

@end

@implementation MessageViewController


@synthesize textBoxField;
@synthesize otherEmail;
@synthesize tableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       //NSLog(@"the other email was set too %@", otherEmail);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     //NSLog(@"the other email was set too %@", otherEmail);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // NSLog(@"the other email was set too %@", otherEmail);
    NSLog(@"other email = %@",email);
    GetConversationConnection *conversationConnection =[[GetConversationConnection alloc] init];
    [conversationConnection createConnection:[WTTSingleton sharedManager].userprofile.email receiverEmail:email];
    conversationConnection.delegate = self;
}

/*
 * Responsible for sending message, sender email, receiver email to PHP, and the PHP updates the database accordingly.
 */

-(IBAction)clickSendButton
{
    [self.textBoxField resignFirstResponder];
    SendMessageConnection* connection = [[SendMessageConnection alloc]init];
    NSLog(@"email = %@",email);
    //NSLog(@"text field = %@",textBoxField.text);
    [connection createConnection:[WTTSingleton sharedManager].userprofile.email receiverEmail:email message:textBoxField.text];
    connection.delegate = self;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if ([conversationArr count] != 0) {
        return [conversationArr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    if ([conversationArr count] != 0)
    {
        NSDictionary *dict = [conversationArr objectAtIndex:indexPath.row];
        NSLog(@"%@",dict);
        NSString *sender = [dict objectForKey:@"sender_email"];
        if ([sender isEqualToString:[WTTSingleton sharedManager].userprofile.email]) {
            CellIdentifier = @"Cell1";
        }
        else if ([sender isEqualToString:email])
        {
            CellIdentifier = @"Cell2";
        }
        
          
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        // Configure the cell...

        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
        UILabel*  senderLabel = (UILabel *) [cell viewWithTag:1];
        senderLabel.text = sender;
        
        NSString * message = [dict objectForKey:@"content"];
        UITextView * messageLabel = (UITextView *)[cell viewWithTag:2];
        messageLabel.text = message;
        
            
        return cell;
    }
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
    

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



- (void)viewDidUnload {
    [self setTextBoxField:nil];
    [super viewDidUnload];
}

/*
 * Dissmis the keyboard when the return button is pressed
 * Connect this function to Did End on Exit of the text field from
 * storyboard
 * @param sender, the textfield responder
 */
- (IBAction) textFieldFinishedWithKeyBoard:(id)sender {
    [sender resignFirstResponder];
}

//Loading conversation after receive json
-(void) finishedGetConversation
{
    conversationArr = [WTTSingleton sharedManager].json;
    NSLog(@"Converstaion : %@",conversationArr);
    [self.tableView reloadData];
}
//Get the conversation after successful sent message
-(void) finished
{
    GetConversationConnection *conversationConnection =[[GetConversationConnection alloc] init];
    [conversationConnection createConnection:[WTTSingleton sharedManager].userprofile.email receiverEmail:email];
    conversationConnection.delegate = self;
}

//Populate view 
- (void) populateView:emailOther
{
    email = emailOther;
}
@end