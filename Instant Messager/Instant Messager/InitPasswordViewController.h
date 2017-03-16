//
//  InitPasswordViewController.h
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import <UIKit/UIKit.h>

@interface InitPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbDesc;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnEnter;

@end
