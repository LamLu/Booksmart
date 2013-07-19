//
//  LIstOfSellerViewController.m
//  Booksmart
//
//  Created by Thanh Au on 6/27/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "LIstOfSellerViewController.h"

@interface LIstOfSellerViewController ()

@end

@implementation LIstOfSellerViewController

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
    ListOfSellerConnection *connection = [[ListOfSellerConnection alloc]init];
    [connection createConnection:bookTitle];
    connection.delegate = self;
}

-(void)populateView:book
{
    _book = book;
    bookTitle = [book bookTitle];
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
    if ([listOfSeller count] != 0)
    {
        return [listOfSeller count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ([listOfSeller count] != 0 )
    {
        //UILabel*  senderLabel = (UILabel *) [cell viewWithTag:1];
        UILabel* nameLabel = (UILabel *) [cell viewWithTag:2];
        NSString *name = [[listOfSeller objectAtIndex:indexPath.row]objectForKey:@"full_name"];
        
        nameLabel.text = name;
        NSString *imgLink = [NSString stringWithFormat:@"%@%@",[WTTSingleton sharedManager].serverURL,[[listOfSeller objectAtIndex:indexPath.row]objectForKey:@"profile_img_src"]];
        UIImageView *imgView =  (UIImageView *) [cell viewWithTag:1];
        
        if (![imgLink isEqualToString:[WTTSingleton sharedManager].serverURL])
        {
            NSLog(@"img link = %@",imgLink);
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgLink]];
            UIImage* profileImage = [UIImage imageWithData:imageData];
            [imgView setImage:profileImage];
        }
        
        
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
-(void) finishedListOfSellerConnection
{
    
    
    listOfSeller = [WTTSingleton sharedManager].json;
    NSLog(@"list of seller : %@",listOfSeller);
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ToUserProfile"])
    {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
        OtherProfileViewController *detailView = (OtherProfileViewController *)[segue destinationViewController];
        
        UIImageView *imgView = (UIImageView *)[selectedCell viewWithTag:1];
        
        //[detailView populateView:[imgView image] name:[[listOfSeller objectAtIndex:indexPath.row]objectForKey:@"full_name"]  description:@"description" location:@"location" school:@"school" email:[[listOfSeller objectAtIndex:indexPath.row]objectForKey:@"email"] book:_book];
        [detailView populateView:[imgView image] name:[[listOfSeller objectAtIndex:indexPath.row]objectForKey:@"full_name"]  description:@"description" location:@"location" school:@"school" email:[[listOfSeller objectAtIndex:indexPath.row]objectForKey:@"email"]];
        
        
    }
}


@end
