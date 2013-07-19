//
//  Book.m
//  Booksmart
//
//  Created by Lam Lu on 7/15/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "Book.h"

@implementation Book
@synthesize bookId, bookTitle, bookEdition, bookAuthors, bookISBN10, bookISBN13, bookPublisher;
@synthesize bookImg1, bookImg2, bookSubjects;

//initialize
- (id) init
{
    return [self initBook:0 title:nil edition:nil authors:nil isbn10:nil isbn13:nil publisher:nil img1:nil img2:nil subjects:nil];
}


//custom initialize
//this is designated initilizer
- (id) initBook: (int) bid title : (NSMutableString *) title edition : (NSMutableString *) edition authors: (NSMutableArray*) authors isbn10: (NSMutableString*)isbn10 isbn13: (NSMutableString*)isbn13 publisher:(NSMutableString*)publisher img1:(UIImage *)img1 img2:(UIImage *) img2 subjects:(NSMutableArray *) subjects
{
    if (self = [super init])
    {
        bookId = bid;
        bookTitle = title;
        bookEdition = edition;
        bookAuthors = authors;
        bookISBN10 = isbn10;
        bookISBN13 = isbn13;
        bookPublisher = publisher;
        bookImg1 = img1;
        bookImg2 = img2;
        bookSubjects = subjects;
    }
    return self;
}


- (void) setBookInfo : (UIImage *) img setTitle : (NSMutableString *) title setEdition : (NSMutableString *) edition  setAuthor: (NSMutableArray*) author setISBN10: (NSMutableString *) ISBN10 setISBN13 : (NSMutableString *)ISBN13
{
    self.bookTitle = title;
    self.bookImg1= img;
    self.bookEdition = edition;
    self.bookAuthors = author;
    self.bookISBN10 = ISBN10;
    self.bookISBN13 = ISBN13;
    title = nil;
    img = nil;
    edition = nil;
    ISBN10 = nil;
    ISBN13 = nil;
}
@end
