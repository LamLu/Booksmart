//
//  DisplayBookInfoViewController.m
//  Booksmart
//
//  Created by Thanh Au on 8/19/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "DisplayBookInfoViewController.h"

@interface DisplayBookInfoViewController ()

@end

@implementation DisplayBookInfoViewController
static const CGFloat  KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MIMIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.6;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 160;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;
static const CGFloat OFFSET = 10;
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
	// Do any additional setup after loading the view.
    //[self.bookImg setImage:bookImage];
    UIImage *image = [UIImage imageNamed:@"book_info_header.png"];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    //navBar.tintColor = [UIColor yellowColor];
    [navBar setContentMode:UIViewContentModeScaleAspectFit];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsLandscapePhone];
    

    if (bookImage != nil)
        self.bookImg.image = bookImage;
    else
        [self.bookImg setImage: [UIImage imageNamed:@"book_default.png"]];
    [self.bookTitleLabel setText:titleBook];
    [self.bookISBN10Label setText:ISBNBook10];
    [self.bookISBN13Label setText:ISBNBook13];
    [self.bookEditionLabel setText:editionBook];
    animatedDistance = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (IBAction)updateChange:(id)sender {
}

- (IBAction) textFieldFinishedWithKeyBoard:(id)sender {
    [sender resignFirstResponder];
}
- (void)populateView:(Book *)book
{
    _book = book;
    titleBook = [book bookTitle];
    editionBook = [book bookEdition];
    ISBNBook10 = [book bookISBN10];
    
    authorBook = [book bookAuthors];
    ISBNBook10 = [book bookISBN10];
    ISBNBook13 = [book bookISBN13];
    bookImage = [book bookImg1];
    //subjectBook = [book bookSubjects];
    
}

- (void)viewDidUnload {
    [self setBookImg:nil];
    [self setBookTitleLabel:nil];
    [self setBookAuthorLabel:nil];
    [self setBookEditionLabel:nil];
    [self setBookISBN10Label:nil];
    [self setBookISBN13Label:nil];
    [self setBookSubjectLabel:nil];
    [self setBookProfessorLabel:nil];
    [super viewDidUnload];
}
//Dismisses Keyboard when anything but the text field is touched
- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
        if ([view isKindOfClass:[UITextView class]]) {
            [view resignFirstResponder];
        }
    }
}

- (IBAction) textFieldDidBeginEditing:(UITextField *)textField
{
    //NSLog(@"location of text field = %f",textField.frame.origin.y + textField.frame.size.height);
    //NSLog(@"haft heigh = %f", self.view.frame.size.height/2);
    if (textField.frame.origin.y + textField.frame.size.height + OFFSET > self.view.frame.size.height / 2) {
        CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
        CGRect viewRect = [self.view.window convertRect:self.view.bounds toView:self.view];
        CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
        CGFloat numerator = midline - viewRect.origin.y - MIMIMUM_SCROLL_FRACTION * viewRect.size.height;
        CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MIMIMUM_SCROLL_FRACTION) * viewRect.size.height;
        CGFloat heightFraction = numerator / denominator;
        if (heightFraction < 0.0)
        {
            heightFraction = 0;
        }
        else if (heightFraction > 1.0)
        {
            heightFraction = 1.0;
        }
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
            //NSLog(@"%f",animatedDistance);
        }
        else
        {
            animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
        }
        CGRect viewFrame = self.view.frame;
        
        viewFrame.origin.y -= animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];

    }
    else
    {
        animatedDistance = 0;
    }
        
}
-(IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    //[self.view setFrame:originView.frame];
    [UIView commitAnimations];
}

@end
