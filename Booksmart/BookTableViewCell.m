//
//  BookTableViewCell.m
//  Booksmart
//
//  Created by Thanh Au on 8/20/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "BookTableViewCell.h"

@implementation BookTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}- (void)willTransitionToState:(UITableViewCellStateMask)aState
{
    [super willTransitionToState:aState];
    state = aState;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // no indent in edit mode
    self.contentView.frame = CGRectMake(0,
                                        self.contentView.frame.origin.y,
                                        self.contentView.frame.size.width,
                                        self.contentView.frame.size.height);
    
    if (self.editing )
    {
        NSLog(@"subview");
        float indentPoints = -100;
        NSLog(@"%f",indentPoints);
        switch (state) {
            case 3:
                NSLog(@"normal");
                self.contentView.frame = CGRectMake(indentPoints,
                                                    self.contentView.frame.origin.y,
                                                    self.contentView.frame.size.width +124,// - indentPoints,
                                                    self.contentView.frame.size.height);
                
                break;
            case 2:
                // swipe action
                NSLog(@"swipe action");
                
                self.contentView.frame = CGRectMake(indentPoints,
                                                    self.contentView.frame.origin.y,
                                                    self.contentView.frame.size.width +75,// - indentPoints,
                                                    self.contentView.frame.size.height);
                /*
                for (UIView *subview in self.subviews)
                {
                    NSLog(@"%@",[subview class]);
                    if ([NSStringFromClass([subview class]) isEqualToString:@"UIButton"])
                    {
                        
                        NSLog(@"tessting");
                        [subview removeFromSuperview];
                        
                        //[self addSubview:deleteBtn];
                    }
                    if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"])
                    {
                        UIView *deleteButtonView = (UIView *)[subview.subviews objectAtIndex:0];
                        
                        //UIImageView *deleteBtn = [[UIImageView alloc]initWithFrame:subview.frame];
                        //[deleteBtn setImage:[UIImage imageNamed:@"active.png"]];
                        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"active.png"]];
                        [deleteButtonView addSubview:image];
                         
                        
                        
                        UIImageView *deleteBtn = [[UIImageView alloc]initWithFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y, 200, 200)];
                        [deleteBtn setImage:[UIImage imageNamed:@"active.png"]];
                        
                        //[[subview.subviews objectAtIndex:0] addSubview:deleteBtn];
                        [subview addSubview:deleteBtn];
                        [subview bringSubviewToFront:deleteBtn];
                        //[subview removeFromSuperview];
                        
                        [self addSubview:deleteBtn];
                 
                    }
                 
                }
                */
                break;
            default:
                NSLog(@"default");
                // state == 1, hit edit button
                self.contentView.frame = CGRectMake(indentPoints,
                                                    self.contentView.frame.origin.y,
                                                    self.contentView.frame.size.width +80,// - indentPoints,
                                                    self.contentView.frame.size.height);  
                break;
        }
        
    }
}

@end
