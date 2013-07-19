//
//  Book.h
//  Booksmart
//
//  Created by Lam Lu on 7/15/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, assign) int bookId;
@property (nonatomic, retain) NSMutableString *bookTitle;
@property (nonatomic, retain) NSMutableString *bookEdition;
@property (nonatomic, retain) NSMutableArray *bookAuthors;
@property (nonatomic, retain) NSMutableString* bookISBN10;
@property (nonatomic, retain) NSMutableString* bookISBN13;
@property (nonatomic, retain) NSMutableString* bookPublisher;
@property (nonatomic, retain) UIImage * bookImg1;
@property (nonatomic, retain) UIImage * bookImg2;
@property (nonatomic, retain) NSMutableArray *bookSubjects;

//custom initialize
//this is designated initilizer
- (id) initBook: (int) bid title : (NSMutableString *) title edition : (NSMutableString *) edition authors: (NSMutableArray*) authors isbn10: (NSMutableString*)isbn10 isbn13: (NSMutableString*)isbn13 publisher:(NSMutableString*)publisher img1:(UIImage *)img1 img2:(UIImage *) img2 subjects:(NSMutableArray *) subjects;

- (void) setBookInfo : (UIImage *) img setTitle : (NSMutableString *) title setEdition : (NSMutableString *) edition  setAuthor: (NSMutableArray*) author setISBN10: (NSMutableString *) ISBN10 setISBN13 : (NSMutableString *)ISBN13;
@end
