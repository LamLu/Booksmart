
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
    //[self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
    self.searchBar.delegate = self;
    self.searchResult.delegate = self;
    self.searchResult.dataSource = self;
    
    
    UIImageView *footerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.searchResult.frame.size.width, self.searchResult.frame.size.height)];
    [footerView setImage:[UIImage imageNamed:@"searchBackGround.png"]];
    
    
    self.searchResult.tableFooterView = footerView;
    //self.searchResult.tableFooterView.contentMode = UIViewContentModeScaleAspectFit;
    //[self.searchResult setContentInset:(UIEdgeInsetsMake(0, 50, -500, 0))];
    //self.searchResult.backgroundView = imgView;
    self.searchResult.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    
    
    
   

}

- (void)viewDidAppear:(BOOL)animated
{
    UIImage *image = [UIImage imageNamed:@"search_header.png"];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    //navBar.tintColor = [UIColor yellowColor];
    [navBar setContentMode:UIViewContentModeScaleAspectFit];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsLandscapePhone];
    
    
    
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
    
    
    static NSString *CellIdentifier = @"BookCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if ([listOfBook count] > 0 )
    {
        UILabel* titleLabel = (UILabel*)[cell viewWithTag:2];
        UILabel* authorLabel = (UILabel*)[cell viewWithTag:3];
        UILabel* editionLabel = (UILabel*)[cell viewWithTag:4];
        

        Book *book = [listOfBook objectAtIndex:indexPath.row];
        
        NSMutableArray *authorArray = [book bookAuthors];
        NSString *author = @"";
        
        for (int i = 0; i <[authorArray count]; i++) {
            if ([authorArray count] - 1 == i)
            {
                if (![[authorArray[i] objectForKey:@"name"] isEqual:@""])
                    author = [author stringByAppendingString:[authorArray[i] objectForKey:@"name"]];
            }
            else
            {
                if (![[authorArray[i] objectForKey:@"name"] isEqual:@""])
                    author = [author stringByAppendingFormat:@"%@,",[authorArray[i] objectForKey:@"name"]];
                
            }
        }
        titleLabel.text = [book bookTitle];
        editionLabel.text = [book bookEdition];
        authorLabel.text = author;
        
        
    }
    return cell;
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *scopeSearch = [searchBar.scopeButtonTitles objectAtIndex:searchBar.selectedScopeButtonIndex];
    
    SearchBookConnection *connection = [[SearchBookConnection alloc]init];
    connection.delegate = self;
    
    
    [connection createConnection:searchBar.text scope:scopeSearch];
    
    [self.searchBar resignFirstResponder];
}


// Receive list of book from server
- (void) finished{
    NSLog(@"teeeeeeeee");
    listOfBook = [WTTSingleton sharedManager].json;
    NSLog(@"%@",listOfBook);
    if ([listOfBook count] > 0) {
        
        self.searchResult.tableFooterView = nil;
        self.searchResult.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else
    {
        UIImageView *footerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.searchResult.frame.size.width, self.searchResult.frame.size.height)];
        [footerView setImage:[UIImage imageNamed:@"SearchNoResult.png"]];
        
        
        self.searchResult.tableFooterView = footerView;
    }
    [self.searchResult reloadData];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsScopeBar = YES;
    [searchBar sizeToFit];
    [searchBar setShowsCancelButton:YES animated:YES];
    listOfBook = nil;
    [self.searchResult reloadData];
    return YES;
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsScopeBar = NO;
    [searchBar sizeToFit];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    return YES;
}
// This will get called too before the view appears (when user click on a row)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 

    if ([[segue identifier] isEqualToString:@"ToBookInfo"])
    {
        
        
        NSIndexPath *indexPath = [self.searchResult indexPathForSelectedRow];
        
        BookInfoViewController *detailView = (BookInfoViewController *)[segue destinationViewController];
        
        Book *book = [listOfBook objectAtIndex:indexPath.row];
        NSLog(@"%@",book.bookAuthors);
        [detailView populateView:book];
        
        
    }
 
}
- (void)populateView:(NSString*)input scope:(NSString*) scope
{
    _input = input;
    _scope = scope;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar

{
    [self.searchBar resignFirstResponder];
}

- (void) dismissKeyboard
{
    // add self
    [self.searchBar resignFirstResponder];
}

@end
