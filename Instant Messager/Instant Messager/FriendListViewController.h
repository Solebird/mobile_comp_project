//
//  FriendListViewController.h
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import <UIKit/UIKit.h>
#import "TCTable.h"
#import "SDSegmentedControl.h"
#import "SwipeView.h"
#import "Global.h"

@interface FriendListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SwipeViewDelegate, SwipeViewDataSource, UIGestureRecognizerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet UIView *optionMenu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionMenuOffset;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToGroup;
@property (weak, nonatomic) IBOutlet UIButton *btnLockChat;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteFriend;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@end
