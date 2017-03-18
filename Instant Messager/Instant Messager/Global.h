//
//  UserGlobal.h
//  ShopDaily
//
//  Created by Thomas Cheung on 18/7/2016.
//  Copyright © 2016 Thomas Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "AFNetworking/AFNetworking.h"

@interface Global : NSObject

+ (Global *) getInstance;

-(void)createDataTask:(NSString*)action withParam:(NSDictionary*)param;

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
