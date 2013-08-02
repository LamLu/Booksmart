//
//  MessageMainScreenViewController.m
//  Booksmart
//
//  Created by Lam Lu on 8/1/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "MessageMainScreenViewController.h"

@interface MessageMainScreenViewController ()

@end

@implementation MessageMainScreenViewController

@synthesize sendMessageBoxView;
@synthesize  email;
@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    /*
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    messageVC = [storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    CGFloat width = self.view.window.screen.bounds.size.width;
    CGFloat height = messageVC.view.bounds.size.height;
    CGFloat yCoord = 0 + self.navigationController.navigationBar.frame.size.height;
    messageVC.tableView.frame = CGRectMake (0, yCoord, width, height);

    [self.view addSubview:messageVC.tableView];
     */
    NSLog(@"other email = %@",email);
    GetConversationConnection *conversationConnection =[[GetConversationConnection alloc] init];
    [conversationConnection createConnection:[WTTSingleton sharedManager].userprofile.email receiverEmail:email];
    conversationConnection.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextBoxField:nil];
    [self setSendMessageBoxView:nil];
    
    [self setTableView:nil];
    [super viewDidUnload];
}
- (IBAction)sendButtonClicked:(id)sender {
}

//Populate view
- (void) populateView:(NSString *)emailOther
{
    self.email = emailOther;
}

/*
 * Responsible for sending message, sender email, receiver email to PHP, and the PHP updates the database accordingly.
 */

-(void)clickSendButton
{
    
    /*
     SendMessageConnection* connection = [[SendMessageConnection alloc]init];
     NSLog(@"email = %@",email);
     //NSLog(@"text field = %@",textBoxField.text);
     [connection createConnection:[WTTSingleton sharedManager].userprofile.email receiverEmail:email message:sendMessageBoxVC.textBoxField.text];
     connection.delegate = self;
     */
    
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


/*
 //when scroll is view, stick the sendMessageBox view at the bottom
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
 sendMessageBoxVC.view.transform = CGAffineTransformMakeTranslation(0, scrollView.contentOffset.y);
 }
 
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // this is needed to prevent cells from being displayed above our static view
 [self.tableView bringSubviewToFront:sendMessageBoxVC.view];
 }
 */

@end
