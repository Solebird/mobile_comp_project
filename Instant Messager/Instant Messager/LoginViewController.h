//
//  LoginViewController.h
//  Instant Messager
//
//  Created by Thomas Cheung on 13/3/2017.
//
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnForgot;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@end
