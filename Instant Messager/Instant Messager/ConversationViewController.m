//
//  ConversationViewController.m
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import "ConversationViewController.h"

@interface ConversationViewController ()

@end

@implementation ConversationViewController{
    NSDateFormatter *dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

-(void)initData{
    [self.imgIcon setImage:[UIImage imageNamed:self.icon]];
    [self.lbName setText:self.name];
}

- (IBAction)onClickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickMenu:(id)sender {
    
}

@end
