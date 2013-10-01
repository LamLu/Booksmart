//
//  UserProfile.h
//  Want To Trade
//  This class is to hold the user profile
//  Created by Lam Lu on 3/22/13.
//
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

@property (nonatomic, retain) UIImage  * userimg;
@property (nonatomic, retain) NSString * userFirstName;
@property (nonatomic, retain) NSString * userLastName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSString * major;

/*
 * method to set user profile
 * @param img : UIImage for profile photo
 * @param usrfirstName: NSString user first name
 * @param usrlastName: NSString user last name
 * @param em: the email
 * @param sch: the school
 * @param mj: the major
 */
- (void) setUserProfile : (UIImage *) img setUserFirstName : (NSString *) usrfirstName setUserLastName : (NSString *) usrlastName  setEmail: (NSString*) em setSchool: (NSString *) sch setMajor : (NSString *)mj;


/*
 * get the full name of the user from first name and last name
 * @return NSString a string represents the full name
 */
- (NSString *) getUserFullName;
@end
