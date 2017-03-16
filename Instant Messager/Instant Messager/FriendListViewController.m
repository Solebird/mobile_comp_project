//
//  FriendListViewController.m
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import "FriendListViewController.h"

@interface FriendListViewController ()

@end

@implementation FriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UIImageView *img = [cell viewWithTag:1];
    [img setImage:[UIImage imageNamed:@"secure_chat"]];
    UILabel *name = [cell viewWithTag:2];
    [name setText:[NSString stringWithFormat:@"Friend %d",(int)indexPath.row]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (IBAction)onClickAdd:(id)sender {
}

@end
