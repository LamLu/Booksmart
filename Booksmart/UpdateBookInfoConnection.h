//
//  UpdateBookInfoConnection.h
//  Booksmart
//
//  Created by Thanh Au on 8/28/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTSingleton.h"
#import "Book.h"
@protocol UpdateBookFinisheds <NSObject>

@required
//@param aBool : Yes = success, No = fail
//@param bookArray the array of the books
- (void) isUpdatesSuccessful : (BOOL) aBool;

@end
@interface UpdateBookInfoConnection : NSObject

@end
