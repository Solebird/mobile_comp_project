//
//  AddFriendViewController.m
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController{
    int friendCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    friendCount = 0;
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (IBAction)onClickEnter:(id)sender {
    friendCount++;
    [self.tableView reloadData];
}
- (IBAction)onClickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return friendCount;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row: %d", (int)indexPath.row);
    NSString *msg = [NSString stringWithFormat:@"Add Friend %d to friend list?", (int)indexPath.row];
    UIAlertController *alert =  [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self showAddedAlert];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)showAddedAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Added!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
