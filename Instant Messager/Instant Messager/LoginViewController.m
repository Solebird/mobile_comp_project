//
//  LoginViewController.m
//  Instant Messager
//
//  Created by Thomas Cheung on 13/3/2017.
//
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    bool needInitPassword;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    needInitPassword = false;
}

-(void)viewDidAppear:(BOOL)animated{
    [self initUI];
}

- (void)initUI{
    //Textfield
    [self.tfEmail setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}]];
    [self.tfPassword setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}]];
    [self addBottomLineToTextField:self.tfEmail];
    [self addBottomLineToTextField:self.tfPassword];
    
    //Login button: round corner
    [[self.btnLogin layer] setCornerRadius:2.0f];
    [[self.btnLogin layer] setMasksToBounds:YES];
}

- (void)addBottomLineToTextField:(UITextField*)tf{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, tf.frame.size.height-1, tf.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [tf.layer addSublayer:bottomBorder];
}

- (IBAction)onClickLogin:(id)sender {
    if (needInitPassword)
        [self performSegueWithIdentifier:@"init_password" sender:self];
    else
        [self performSegueWithIdentifier:@"friend_list" sender:self];
}

@end
