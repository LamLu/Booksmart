//
//  TradingProcessViewController.h
//  Booksmart
//
//  Created by Thanh Au on 7/23/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradingProcessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITableView *OfferItemTable;
@property (weak, nonatomic) IBOutlet UITableView *WantedItemTable;

@end
