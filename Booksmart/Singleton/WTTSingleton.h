//
//  WTTSingleton.h
//  Want To Trade
//  This is the singleton for want to trade
//  Created by Lam Lu on 3/22/13.
//
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"
#import "UserProfile.h"

@interface WTTSingleton : NSObject

//property to check the login
@property (nonatomic, assign) BOOL isLogin;

//keychain to hold user credentials: username and password
@property (nonatomic, retain) KeychainItemWrapper* keychainItem;

//userprofile property
@property (nonatomic, retain) UserProfile * userprofile;

//the URL to the user that contains php, userProfile images...
@property (nonatomic, retain) NSString * serverURL;



// method to return this Singleton
+ (WTTSingleton *) sharedManager;

// method to store email and password into keychain
// keychain is used to store email and password only
// @param: email the email to be stored
// @password: the password to be stored
- (void) storeUserCredentials : (NSString *) email  storePassword: (NSString *) password;

/*
 * method to store user profile into NSUserDefault
 * @param img: the default img
 * @param name: the default name
 * @param em: the default email
 * @param sch: the default school
 * @param mj: the default major
 */
- (void) storeDefaultUserProfile: (UIImage *) img defaultName: (NSString *) name defaultEmail : (NSString *) em defaultSchool: (NSString *) sch defaultMajor: (NSString *) mj;
@end
