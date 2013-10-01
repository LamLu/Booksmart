//
//  KBKeyboardHandler.h
//  Booksmart
//
//  Created by Thanh Au on 9/16/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol KBKeyboardHandlerDelegate
-(void)keyboardSizeChanged:(CGSize)delta;
@end

@interface KBKeyboardHandler : NSObject
- (id)init;
@property (nonatomic, weak) id<KBKeyboardHandlerDelegate> delegate;
@property (nonatomic) CGRect frame;

@end
