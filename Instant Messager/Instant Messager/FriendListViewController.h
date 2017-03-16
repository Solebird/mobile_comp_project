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

@interface FriendListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SwipeViewDelegate, SwipeViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@end
