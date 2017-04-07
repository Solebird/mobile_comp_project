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
    TCTable *friends;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (IBAction)onClickEnter:(id)sender {
    [[Global getInstance] showLoading:self.view];
    NSDictionary *param = @{@"nameString":self.tfUsername.text};
    [[Global getInstance] createDataTask:@"searchFriend" withParam:param withCompletionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }else{
            NSLog(@"ResponseObject: %@", responseObject);
            NSDictionary *status = [responseObject objectForKey:@"status"];
            if ([[status objectForKey:@"number"] intValue]==0){
                NSArray *data = [responseObject objectForKey:@"data"];
                friends = [TCTable new];
                for (NSDictionary *friend in data) {
                    [friends addRecord:[friend objectForKey:@"userID"],[friend objectForKey:@"username"],[friend objectForKey:@"icon"],nil];
                }
                [friends printArray];
                [self.tableView reloadData];
            }else{
                [[Global getInstance] showOkAlertBox:[status objectForKey:@"message"] inVC:self];
            }
        }
        [[Global getInstance] hideLoading];
    }];
}
- (IBAction)onClickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [friends count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UIImageView *img = [cell viewWithTag:1];
    [img setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon%@.jpg",[friends getObject:2 fromRow:indexPath.row]]]];
    [img setContentMode:UIViewContentModeScaleAspectFill];
    [[Global getInstance] setCircleImage:img];
    
    UILabel *name = [cell viewWithTag:2];
    [name setText:[friends getObject:1 fromRow:indexPath.row]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row: %d", (int)indexPath.row);
    NSString *msg = [NSString stringWithFormat:@"Add Friend %d to friend list?", (int)indexPath.row];
    UIAlertController *alert =  [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showAddedAlert];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)showAddedAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Added!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
