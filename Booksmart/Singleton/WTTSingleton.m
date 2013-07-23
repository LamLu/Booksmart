//
//  WTTSingleton.m
//  Want To Trade
//  This is the singleton for want to trade
//  Created by Lam Lu on 3/22/13.
//
//

#import "WTTSingleton.h"

@implementation WTTSingleton
@synthesize isLogin;
@synthesize keychainItem;
@synthesize userprofile;
@synthesize serverURL;
@synthesize ratingPercentage;
@synthesize json;
@synthesize book, bookArray;


#pragma mark Singleton Methods

+ (WTTSingleton *)sharedManager
{
    static WTTSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WTTSingleton alloc] init];
        sharedInstance.isLogin = NO;
        sharedInstance.keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"WTTLoginData" accessGroup:nil];
        sharedInstance.userprofile = [[UserProfile alloc] init];
        sharedInstance.serverURL = @"https://srv01.hidevmobile.com";//@"http://192.168.1.140:8888"; //@"http://192.168.1.141:8888";//@"https://srv01.hidevmobile.com";
        
        sharedInstance.book = [[Book alloc]init];
        sharedInstance.bookArray = [[NSMutableArray alloc]init];
    });
    
    return sharedInstance;
}

- (void) storeUserCredentials : (NSString *) email storePassword: (NSString *) password
{
    [[WTTSingleton sharedManager].keychainItem resetKeychainItem];
    [keychainItem setObject:email forKey:(__bridge id)kSecAttrAccount];
    [keychainItem setObject:password forKey:(__bridge id)kSecValueData];
    email = nil;
    password = nil;
 
}

- (void) storeDefaultUserProfile: (UIImage *) img defaultName: (NSString *) name defaultEmail : (NSString *) em defaultSchool: (NSString *) sch defaultMajor: (NSString *) mj
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:img forKey:@"userImage"];
    [userDefault setObject:name forKey:@"userName"];
    [userDefault setObject:em forKey:@"userEmail"];
    [userDefault setObject:sch forKey:@"userSchool"];
    [userDefault setObject:mj forKey:@"userMajor"];
    [userDefault synchronize];
}
@end
