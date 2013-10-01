//
//  KBKeyboardHandlerDelegate.h
//  Booksmart
//
//  Created by Thanh Au on 9/16/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol KBKeyboardHandlerDelegate
-(void)keyboardSizeChanged:(CGSize)delta;
@end
@interface KBKeyboardHandlerDelegate : NSObject

@end
