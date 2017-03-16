//
//  ConversationViewController.h
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import <UIKit/UIKit.h>

@interface ConversationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;

@property NSString *icon;
@property NSString *name;

@end
