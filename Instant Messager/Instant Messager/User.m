#import "User.h"

@implementation User
static User *instance = nil;

+(User*)getInstance{
    @synchronized(self){
        if(instance==nil){
            instance = [User new];
        }
    }
    return instance;
}

-(void)printAllProperty{
    NSLog(@"***********************");
    NSLog(@"***********************");
}

//-(void)logout:(UIViewController*)sender{
//    UIViewController *vc = sender.presentingViewController;
//    while (vc.presentingViewController) {
//        vc = vc.presentingViewController;
//    }
//    [vc dismissViewControllerAnimated:YES completion:NULL];
//    instance = nil;
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if (![[userDefaults objectForKey:@"remember"] isEqualToString:@"1"]) {
//        [userDefaults removeObjectForKey:@"phone"];
//        [userDefaults removeObjectForKey:@"password"];
//        [userDefaults removeObjectForKey:@"remember"];
//    }
//    [userDefaults removeObjectForKey:@"login"];
//    [userDefaults synchronize];
//}
@end
