//
//  UploadBookConnection.h
//  Booksmart
//
//  Created by Lam Lu on 6/26/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTSingleton.h"
@protocol ProcessAfterUpload <NSObject>

@required
//@param upload : Yes = success, No = fail
- (void) isUploadSuccessful : (BOOL) upload;

@end

@interface UploadBookConnection : NSObject

@property (nonatomic,retain) id <ProcessAfterUpload> delegate;
@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) UIAlertView *loadingAlertView;

//create connection
- (void)createConnection: (NSString *) email title: (NSString *) bookTitle edition: (NSString *) bookEdition isbn10: (NSString *) bookISBN10 isbn13: (NSString *) bookISBN13 publisher : (NSString *) bookPublisher authors: (NSString *) bookAuthors subject: (NSString *) bookSubject imageArray:(NSMutableArray *) imgArr isWishList: (BOOL) isWishList;
@end
