//
//  SearchForBookViewController.m
//  Booksmart
//
//  Created by Thanh Au on 6/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "SearchForBookViewController.h"

@interface SearchForBookViewController ()

@end

@implementation SearchForBookViewController

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
    [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
    self.searchBar.delegate = self;
    self.searchResult.delegate = self;
    self.searchResult.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [self setSearchResult:nil];
    [super viewDidUnload];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    return YES;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([listOfBook count] != 0 )
    {
        return  [listOfBook count];
    }
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if ([listOfBook count] != 0 )
    {
        UILabel* nameLabel = (UILabel *) [cell viewWithTag:2];
        NSString *name = [[listOfBook objectAtIndex:indexPath.row]objectForKey:@"full_name"];
        NSLog(@"name = %@", name);
        nameLabel.text = name;
        
        //NSString *imgLink = [NSString stringWithFormat:@"%@%@",[WTTSingleton sharedManager].serverURL,[[listOfBook objectAtIndex:indexPath.row]objectForKey:@"profile_img_src"]];
        /*
        UIImageView *imgView =  (UIImageView *) [cell viewWithTag:1];
        
        if (![imgLink isEqualToString:[WTTSingleton sharedManager].serverURL])
        {
            NSLog(@"img link = %@",imgLink);
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgLink]];
            UIImage* profileImage = [UIImage imageWithData:imageData];
            [imgView setImage:profileImage];
        }
        */
    }
    return cell;
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    SearchBookConnection *connection = [[SearchBookConnection alloc]init];
    connection.delegate = self;
    
    //[searchForUser createConnection:@"lam lu"];
    [connection createConnection:searchBar.text];
    
    [self.searchBar resignFirstResponder];
}

//dismiss the numpad keyboard when the user tap outside the keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.searchBar resignFirstResponder];
}

// Receive list of book from server
- (void) finished{
    //NSLog(@"teeeeeeeee");
    listOfBook = [WTTSingleton sharedManager].json;
    NSLog(@"%@",listOfBook);
    //[self.searchResult reloadData];
    
}




// This will get called too before the view appears (when user click on a row)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    if ([[segue identifier] isEqualToString:@"ToUserProfile"])
    {
        
        NSIndexPath *indexPath = [self.searchResult indexPathForSelectedRow];
        UITableViewCell *selectedCell = [self.searchResult cellForRowAtIndexPath:indexPath];
        OtherProfileViewController *detailView = (OtherProfileViewController *)[segue destinationViewController];
        
        UIImageView *imgView = (UIImageView *)[selectedCell viewWithTag:1];
        [detailView populateView:[imgView image] name:@"name" description:@"description" location:@"location" school:@"school" email:[[listOfUser objectAtIndex:indexPath.row]objectForKey:@"email"]];
        
        
    }
     */
}

@end
