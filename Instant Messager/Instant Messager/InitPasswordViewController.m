//
//  InitPasswordViewController.m
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import "InitPasswordViewController.h"

@interface InitPasswordViewController ()

@end

@implementation InitPasswordViewController{
    bool isReal;
    NSString *realPassword;
    NSString *fakePassword;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isReal = true;
    [self initUI];
}

-(void)initUI{
    [self.lbTitle setText:@"Real Password"];
    [self.lbDesc setText:@"This password is required for viewing all the conversations, including secret conversations.\nYou may change it later in Setting."];
    [self.tfPassword setPlaceholder:@"Real Password"];
    [self.tfPassword setText:@""];
}

- (IBAction)onClickEnter:(id)sender {
    if (isReal){
        realPassword = self.tfPassword.text;
        [self goToFake];
    }else{
        fakePassword = self.tfPassword.text;
        [self goToFriendList];
    }
}
-(void)goToFake{
    isReal = false;
    [self.tfPassword resignFirstResponder];
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.lbTitle setAlpha:0];
        [self.lbDesc setAlpha:0];
        [self.tfPassword setAlpha:0];
        [self.btnEnter setAlpha:0];
    } completion:^(BOOL finished) {
        
        [self.lbTitle setText:@"Fake Password"];
        [self.lbDesc setText:@"Entering this password can only view those conversations which have not been set as secret.\nYou may change it later in Setting."];
        [self.tfPassword setPlaceholder:@"Fake Password"];
        [self.tfPassword setText:@""];
        
        [UIView animateWithDuration:.5 delay:.2 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.lbTitle setAlpha:1];
            [self.lbDesc setAlpha:1];
            [self.tfPassword setAlpha:1];
            [self.btnEnter setAlpha:1];
        } completion:nil];
    }];
}

-(void)goToFriendList{
    [self.tfPassword resignFirstResponder];
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.lbTitle setAlpha:0];
        [self.lbDesc setAlpha:0];
        [self.tfPassword setAlpha:0];
        [self.btnEnter setAlpha:0];
    } completion:^(BOOL finished){
        [self performSegueWithIdentifier:@"friend_list" sender:self];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"friend_list"]){
        
    }
}

@end
