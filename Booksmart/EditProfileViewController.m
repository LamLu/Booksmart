//
//  EditProfileViewController.m
//  Booksmart
//
//  Created by Thanh Au on 9/18/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

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
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userName = [user stringForKey:@"userName"];
    userSchool = [user stringForKey:@"userSchool"];
    NSData * imageData = [user dataForKey:@"userImage"];
    userEmail = [[WTTSingleton sharedManager].keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    
    if (imageData != nil ) {
        UIImage *tempImg = [UIImage imageWithData:imageData];
        [self.editButtonItem setImage:tempImg];
        tempImg = nil;
    }

    NSArray *tempArray = [userName componentsSeparatedByString:@" "];
    userFirstName = [tempArray objectAtIndex:0];
    userLastName = [tempArray objectAtIndex:1];
    self.firstNameLabel.text = userFirstName;
    self.lastNameLabel.text = userLastName;
    self.schoolLabel.text = userSchool;
    self.emailLabel.text = userEmail;
    
    self.firstNameLabel.delegate = self;
    self.lastNameLabel.delegate = self;
    self.emailLabel.delegate = self;
    self.schoolLabel.delegate = self;
    self.descriptionLabel.delegate = self;
    
    user = nil;
    userName = nil;
    imageData = nil;
    tempArray = nil;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editPicture:(id)sender {
    NSString *activeSheetTitle = @"Change Profile Picture";
    NSString *removePicture =
        @"Remove Current Photo";
    NSString *takePhoto = @"Take Photo";
    NSString * chooseFromLibrary = @"Choose From Librabry";
    NSString *cancleTitle = @"Cancel";
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:activeSheetTitle delegate:self cancelButtonTitle:cancleTitle destructiveButtonTitle:removePicture otherButtonTitles:takePhoto,chooseFromLibrary, nil];
    [actionSheet showInView:self.view];

}

- (IBAction)changePassword:(id)sender {
}

- (IBAction)cancle:(id)sender {
    
    NSLog(@"username = %@, %@",userFirstName,self.firstNameLabel.text);
    if (self.imgUser != nil || ![userEmail isEqualToString:self.emailLabel.text] || ![userSchool isEqualToString:self.schoolLabel.text] || ![userFirstName isEqualToString:self.firstNameLabel.text] || ![userLastName isEqualToString:self.lastNameLabel.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsaved Changes" message:@"You have unsaved changes. Are you sure you want to cancel?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
     
}

- (IBAction)done:(id)sender {
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Remove Current Photo"]) {
        NSLog(@"Delete pic");
    }
    else if ([buttonTitle isEqualToString:@"Take Photo"])
    {
        [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    }
    else if ([buttonTitle isEqualToString:@"Choose From Librabry"])
    {
        [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Yes"]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
 
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    [textField resignFirstResponder];
    return YES;
}
//Dismisses Keyboard when anything but the text field is touched
- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {

    for (UIView* view in self.view.subviews) {
        //NSLog(@"%@",[view class]);
        if ([view isKindOfClass:[CustomTextField class]] || [view isKindOfClass:[UITextView class]])
            [view resignFirstResponder];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (void)pickMediaFromSource:(UIImagePickerControllerSourceType) sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error accessing media" message:@"Device doesn't support that media source" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (UIImage *) shrinkImage:(UIImage *) original toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [original drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return final;
}


#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imgUser = info[UIImagePickerControllerEditedImage];
    UIImage *shrunkenImage = [self shrinkImage:self.imgUser toSize:self.imgButton.bounds.size];
    [self.imgButton setImage:shrunkenImage forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
