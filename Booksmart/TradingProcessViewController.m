//
//  TradingProcessViewController.m
//  Booksmart
//
//  Created by Thanh Au on 7/23/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "TradingProcessViewController.h"

@interface TradingProcessViewController ()

@end

@implementation TradingProcessViewController

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
    
	
    

    
    self.traderLabel.text = trader;
    self.WantedItemTable.delegate = self;
    self.OfferItemTable.delegate = self;
    self.WantedItemTable.dataSource = self;
    self.OfferItemTable.dataSource = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLocation:nil];
    [self setTime:nil];
    [self setOfferItemTable:nil];
    [self setWantedItemTable:nil];
    [self setTraderLabel:nil];
    [super viewDidUnload];
}
-(void)populateView:(NSString *) email book:(Book*)book
{
    
    trader = email;
    NSLog(@"trader is %@",trader);
    wantedBook = book;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"teeeee");
    if (tableView == self.OfferItemTable)
    {
        NSLog(@"Offer item tag");
        return 1;
    }
    else 
    {
        NSLog(@"Wanted item tag");
        return 1;
    }

}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == self.WantedItemTable) {
        NSLog(@"In offer table");
        static NSString *CellIdentifier = @"OfferItem";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        return cell;
    }
    else if (tableView == self.OfferItemTable)
    {
        NSLog(@"In wanted table");
        static NSString *CellIdentifier = @"WantedItem";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [wantedBook bookTitle];
        return cell;
       
    }
    
    return cell;
        
}


@end
