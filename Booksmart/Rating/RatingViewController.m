//
//  RatingViewController.m
//  Booksmart
//
//  Created by test on 6/14/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "RatingViewController.h"

@interface RatingViewController ()

@end

@implementation RatingViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    DisplayRatingConnection *connection = [[DisplayRatingConnection alloc]init];
    //NSLog(@"User email =%@", userEmail);
    [connection createConnection:userEmail];
    connection.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)populateView:(NSString *) email
{
    userEmail = email;
}
-(void) finished
{
    NSLog(@"ttttttttttt");

    //ratingArr = [[NSArray alloc]initWithArray:[[WTTSingleton sharedManager].json]];
    ratingArr = [WTTSingleton sharedManager].json;
    NSLog(@"rating : %@",ratingArr);
    [self.tableView reloadData];
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
    if ([ratingArr count] != 0)
    {
        return [ratingArr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ([ratingArr count] != 0 )
    {
        //UILabel*  senderLabel = (UILabel *) [cell viewWithTag:1];
        UILabel* ratingLabel = (UILabel *) [cell viewWithTag:1];
        NSString *rating = [[[ratingArr objectAtIndex:indexPath.row]objectForKey:@"rating"] stringValue];
        
        ratingLabel.text = rating;
        
        UILabel* raterEmailLabel = (UILabel *) [cell viewWithTag:2];
        NSString *raterEmail = [[ratingArr objectAtIndex:indexPath.row]objectForKey:@"email"];
        
        raterEmailLabel.text = raterEmail;
        
        UILabel* raterCommentLabel = (UILabel *) [cell viewWithTag:3];
        NSString *raterComment = [[ratingArr objectAtIndex:indexPath.row]objectForKey:@"rater_comment"];
        
        raterCommentLabel.text = raterComment;
        
    }

    
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

@end
