//
//  InventoryViewController.m
//  Booksmart
//
//  Created by Lam Lu on 7/15/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "InventoryViewController.h"

@interface InventoryViewController ()

@end

@implementation InventoryViewController
@synthesize bookArray;

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
    //bookArray = [[NSArray alloc] init];
    
    UIImage *image =[[UIImage alloc]init];
    if (email != nil)
    {
        image = [UIImage imageNamed:@"library_header.png"];
        
    }
    else
    {
        image = [UIImage imageNamed:@"my_library_header.png"];
    }
    
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    //navBar.tintColor = [UIColor yellowColor];
    [navBar setContentMode:UIViewContentModeScaleAspectFit];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsLandscapePhone];
    image = nil;
    InventoryConnection *connection = [[InventoryConnection alloc] init];
    [connection setDelegate:self];
    
    if (email != nil)
    {
        NSLog(@"%@",email);
        [connection createConnection:email];
    }
    else
    {
        NSLog(@"%@",[WTTSingleton sharedManager].userprofile.email);
        [connection createConnection:[WTTSingleton sharedManager].userprofile.email];
        //[connection createConnection:@"cowboy"];
    }
    connection = nil;
    self.tableView.tableFooterView = [[UIView alloc] init];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"upload_second_half.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
}
- (void)viewDidAppear:(BOOL)animated
{
    /*
    UIImage *image =[[UIImage alloc]init];
    if (email != nil)
    {
        image = [UIImage imageNamed:@"library_header.png"];
        
    }
    else
    {
        image = [UIImage imageNamed:@"my_library_header.png"];
    }
    
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    //navBar.tintColor = [UIColor yellowColor];
    [navBar setContentMode:UIViewContentModeScaleAspectFit];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsLandscapePhone];
    image = nil;
    */
    
    
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
    if (bookArray == nil)
        return 0;

    // Return the number of rows in the section.
    return bookArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog (@"load first");
    static NSString *CellIdentifier = @"BookCell";
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
    
        // No cell to reuse => create a new one
        cell = [[BookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }

    
  
    if (bookArray.count > 0)
    {
        Book * aBook = (Book*)[bookArray objectAtIndex:indexPath.row];
        
        UIImageView * imageView = (UIImageView *) [cell viewWithTag:1];
        if (aBook.bookImg1 == nil)
            [imageView setImage: [UIImage imageNamed:@"book_default.png"]];
        
        if (aBook.bookImg1 != nil)
            [imageView setImage:aBook.bookImg1];
        imageView = nil;
        
        //get title of the book
        UILabel* title = (UILabel*)[cell viewWithTag:2];
        UILabel* author = (UILabel*)[cell viewWithTag:3];
        UILabel* edition = (UILabel*)[cell viewWithTag:4];
        
        
        if (aBook.bookTitle != nil)
        {
            //NSLog(@"book Title = %@",aBook.bookTitle );
            title.text = aBook.bookTitle;
        }
        if (aBook.bookAuthors != nil)
        {
            NSMutableArray *authorArray = [aBook bookAuthors];
            NSString *authorString = @"";
            
            for (int i = 0; i <[authorArray count]; i++) {
                if ([authorArray count] - 1 == i)
                {
                    NSString *temp = authorArray[i];
                    if (![temp isEqual:@""])
                        authorString = [authorString stringByAppendingString:temp];
                    temp = nil;
                }
                else
                {
                    NSString *temp = authorArray[i];
                    if (![temp isEqual:@""])
                        authorString = [authorString stringByAppendingFormat:@"%@,",temp];
                    temp = nil;
                    
                }
            }
            

            //NSLog(@"book Author = %@",aBook.bookTitle );
            author.text = authorString;
        }
        if (aBook.bookEdition != nil)
        {
            //NSLog(@"book Edition = %@",aBook.bookEdition );
            edition.text = aBook.bookEdition;
        }
        title = nil;
        author = nil;
        edition = nil;
        
        

        /*
        imageView = (UIImageView *) [cell viewWithTag:2];
        if (aBook.bookImg2 != nil)
            imageView.image = aBook.bookImg2;
        */
        imageView = nil;
        //NSLog (@"%@", aBook.bookTitle);
        aBook = nil;
    
        
    }
   
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (email == nil)
    {
        return YES;
    }
    return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Book* deleteBook = [bookArray objectAtIndex:indexPath.row];
        //NSLog(@"%i",deleteBook.bookId);
        [bookArray removeObjectAtIndex:indexPath.row];
        DeleteBookConnection *connection = [[DeleteBookConnection alloc]init];
        //[connection setDelegate:self];
        
        [connection createConnection:deleteBook.bookId isWishlist:@"FALSE"];
        
        [tableView reloadData];
    }   
    
}


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

//@param aBool : Yes = success, No = fail
//@param bookArray the array of the books
- (void) isRetrievingSuccessful : (BOOL) aBool bookArray: (NSArray*) array 
{

    
    if (aBool == YES)
    {
        //NSLog (@"load second");
        bookArray = [[NSMutableArray alloc] initWithArray: array];
        //NSLog(@"book array = %@",bookArray);
        [self.tableView reloadData];
    }
    else
    {
        UIAlertView* resultAlertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Cannot retrieve data. Please try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [resultAlertView show];        
    }
     
}
- (void)populateView:(NSString*)otherEmail
{
    email = otherEmail;
    //NSLog(@"%@",email);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([[segue identifier] isEqualToString:@"ToDisplayBook"])
    {
       
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DisplayBookInfoViewController *detailView = (DisplayBookInfoViewController *)[segue destinationViewController];
        
        Book *book = [bookArray objectAtIndex:indexPath.row];
        //NSLog(@"%@",book.bookAuthors);
        [detailView populateView:book];
        
        
    }
    
}


@end
