//
//  UserProfile.m
//  Want To Trade
//
//  Created by Lam Lu on 3/22/13.
//
//

#import "UserProfile.h"

@implementation UserProfile

@synthesize userimg;
@synthesize userFirstName;
@synthesize userLastName;
@synthesize email;
@synthesize school;
@synthesize major;

//initialize
- (id) init
{
    return [self initUserProfile:nil initUserFirstName:nil initUserLastName:nil initEmail:nil initSchool:nil initMajor:nil];
}


//custom initialize
//this is designated initilizer
- (id) initUserProfile: (UIImage *) img initUserFirstName : (NSString *) usrfirstName initUserLastName : (NSString *) usrlastName initEmail: (NSString *) e initSchool : (NSString *) sch initMajor: (NSString *) mj
{
    if (self = [super init])
    {
        userimg = img;
        userFirstName = usrfirstName;
        userLastName = usrlastName;
        email = e;
        school = sch;
        major = mj;
    }
    return self;
}

- (void) setUserProfile : (UIImage *) img setUserFirstName : (NSString *) usrfirstName setUserLastName : (NSString *) usrlastName  setEmail: (NSString*) em setSchool: (NSString *) sch setMajor : (NSString *)mj
{
    self.userimg = img;
    self.userFirstName = usrfirstName;
    self.userLastName = usrlastName;
    self.email = em;
    self.school = sch;
    self.major = mj;
    img = nil;
    usrfirstName = nil;
    usrlastName = nil;
    
    em = nil;
    sch = nil;
    mj = nil;
}

- (NSString *) getUserFullName
{
    if(userFirstName != nil || userLastName != nil)
    {
        if(userFirstName == nil)
            return userLastName;
        
        else if(userLastName == nil)
            return userFirstName;
        
        else return [NSString stringWithFormat:@"%@ %@", userFirstName, userLastName];
    }
    
    else return nil;
}
@end
