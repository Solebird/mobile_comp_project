#import "Global.h"

@interface User : NSObject

@property NSString *userId;
@property NSString *userName;
@property NSString *userEmail;
@property NSString *userIcon;
@property NSString *userPwLock;
@property NSString *friendCount;

+(User*)getInstance;

-(void)printAllProperty;

//-(void)logout:(UIViewController*)sender;

@end
