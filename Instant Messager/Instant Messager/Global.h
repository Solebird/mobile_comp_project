#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "AFNetworking/AFNetworking.h"
#import "User.h"
#import "TCTable.h"


@interface Global : NSObject

+ (Global *) getInstance;

-(void)createDataTask:(NSString*)function withParam:(NSDictionary*)param withCompletionHandler:(void(^)(NSURLResponse *response, id responseObject, NSError *error))handler;

-(void)connectionRequest:(NSString*)action inputData:(NSDictionary*)params completion:(void(^)(NSData *data, NSURLResponse *response,NSError *error))handler;
-(void)extractData:(NSData*)data to:(NSMutableDictionary*)output;

-(void)showLoading:(UIView*)view;
-(void)hideLoading;
-(void)showOkAlertBox:(NSString *)content inVC:(UIViewController*)vc;
-(void)setCircleImage:(UIImageView*)img;
-(void)setRoundButton:(UIButton*)button;

@property MBProgressHUD *hud;
@property bool isShowHud;

@end
