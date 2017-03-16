//
//  FriendListViewController.m
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import "FriendListViewController.h"
#import "TCTable.h"

@interface FriendListViewController ()

@end

@implementation FriendListViewController{
    int addCount;
    TCTable *friends;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    addCount = 0;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self initSegmentControl];
    [self initFriendList];
}

-(void)initFriendList{
    friends = [TCTable new];
    
    //demo data
    [friends addRecord:@"0", @"secure_chat", @"Amy", nil];
    [friends addRecord:@"1", @"secure_chat", @"Bobby", nil];
    [friends addRecord:@"2", @"secure_chat", @"Cat", nil];
    [friends addRecord:@"3", @"secure_chat", @"Daddy", nil];
    
    [self.tableView reloadData];
}

-(void)initSegmentControl{
    [self.segmentControl removeAllSegments];
    [self.segmentControl insertSegmentWithTitle:@"All" atIndex:0 animated:NO];
}

- (IBAction)segmentDidValueChange:(id)sender {
    NSLog(@"Selected segment: %d", (int)self.segmentControl.selectedSegmentIndex);
}

- (IBAction)onClickAddSegment:(id)sender {
    int index = (int)self.segmentControl.numberOfSegments;
    switch (addCount++ % 3){
            case 0:
            [self.segmentControl insertSegmentWithTitle:@"Title Only" atIndex:index animated:YES];
            break;
            
            case 1:
            [self.segmentControl insertSegmentWithImage:[UIImage imageNamed:@"secure_chat"] atIndex:index animated:YES];
            break;
            
            case 2:
            [self.segmentControl insertSegmentWithTitle:@"Title with Image" atIndex:index animated:YES];
            [self.segmentControl setImage:[UIImage imageNamed:@"secure_chat"] forSegmentAtIndex:index];
            break;
    }
    [self.segmentControl setSelectedSegmentIndex:index];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [friends count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UIImageView *img = [cell viewWithTag:1];
    [img setImage:[UIImage imageNamed:[friends getObject:1 fromRow:indexPath.row]]];
    UILabel *name = [cell viewWithTag:2];
    [name setText:[friends getObject:2 fromRow:indexPath.row]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row: %d", (int)indexPath.row);
}

- (IBAction)onClickAddFriend:(id)sender {
}


@end
