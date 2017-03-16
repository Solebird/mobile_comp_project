//
//  FriendListViewController.h
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import <UIKit/UIKit.h>

@interface FriendListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
