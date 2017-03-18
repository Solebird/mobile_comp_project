//
//  UserGlobal.m
//  ShopDaily
//
//  Created by Thomas Cheung on 18/7/2016.
//  Copyright © 2016 Thomas Cheung. All rights reserved.
//

#import "Global.h"

@implementation Global

+ (Global *) getInstance{
    static Global *_default = nil;
    if (_default == nil){ //init
        _default = [[Global alloc] init];
    }
    return _default;
}

-(void)createDataTask:(NSString*)action withParam:(NSDictionary*)param{
    NSString *urlStr = [NSString stringWithFormat:@"http://thomascheung.net/test.php"];
    NSDictionary *parameters = @{@"function": action,
                                 @"email": @"bar",
                                 @"username": @"test",
                                 @"password": @"123"};
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:parameters error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Response: %@", response);
            NSLog(@"ResponseObject: %@", responseObject);
            if (manager.responseSerializer == [AFHTTPResponseSerializer serializer]){
                NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"HTML: %@",html);
            }
        }
    }];
    [dataTask resume];
}

-(void)connectionRequest:(NSString*)action inputData:(NSDictionary*)params completion:(void(^)(NSData *data, NSURLResponse *response,NSError *error))handler{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",action]];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString *BoundaryConstant = [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    for (NSString *param in params) {
        if ([[params objectForKey:param] isKindOfClass:[NSData class]]){
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"photo.jpg\"\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[params objectForKey:param]];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }else{
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:handler];
    [postDataTask resume];
}

-(void)extractData:(NSData*)data to:(NSMutableDictionary*)output{
    if (data!=nil) {
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *temp_output = [output copy];
        for (id key in temp_output) {
            if ([responseData objectForKey:key]!=nil)
                [output setObject:[responseData objectForKey:key] forKey:key];
        }
    }
}

-(void)showLoading:(UIView*)view{
    if (!self.isShowHud){
        self.isShowHud = true;
        self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            if (self.isShowHud)
//                [self hideLoading];
//        });
    }
}

-(void)hideLoading{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
        self.isShowHud = false;
    });
}

-(void)showOkAlertBox:(NSString *)content inVC:(UIViewController*)vc{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:content preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [vc presentViewController:alert animated:YES completion:nil];
}

-(void)setCircleImage:(UIImageView*)img{
    //[img layoutIfNeeded];
    [img.layer setCornerRadius:img.frame.size.width/2];
    [img.layer setMasksToBounds:YES];
}

-(void)setRoundButton:(UIButton*)button{
    [[button layer] setCornerRadius:2.0f];
    [[button layer] setMasksToBounds:YES];
    [[button layer] setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor]];
    [[button layer] setBorderWidth:1.0f];
}


@end
