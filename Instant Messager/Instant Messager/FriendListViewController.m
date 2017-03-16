//
//  FriendListViewController.m
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import "FriendListViewController.h"
#import "ConversationViewController.h"

@interface FriendListViewController ()

@end

@implementation FriendListViewController{
    TCTable *friends;
    int swipeFlag;
    int selectedIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self initSegmentControl];
    [self initSwipeView];
    [self initFriendList];
}

-(void)initSwipeView{
    swipeFlag = 0;
    [self.swipeView setDataSource:self];
    [self.swipeView setDelegate:self];
}

-(void)initSegmentControl{
    [self.segmentControl removeAllSegments];
    [self.segmentControl insertSegmentWithTitle:@"All" atIndex:0 animated:NO];
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

- (IBAction)segmentDidValueChange:(id)sender {
    [self.swipeView scrollToPage:self.segmentControl.selectedSegmentIndex duration:.5];
}
- (IBAction)onClickAddSegment:(id)sender {
    int index = (int)self.segmentControl.numberOfSegments;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Create New Group" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *tf){
        [tf setPlaceholder:@"Group Title"];
        [tf setAutocapitalizationType:UITextAutocapitalizationTypeSentences];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Create" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSString *title = alert.textFields[0].text;
        if (![title isEqualToString:@""]){
            [self.segmentControl insertSegmentWithTitle:title atIndex:index animated:YES];
            [self.segmentControl setSelectedSegmentIndex:index];
            [self.swipeView reloadData];
            [self.swipeView scrollToPage:index duration:.5];
        }else{
            
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    return self.segmentControl.numberOfSegments;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UILabel *label = nil;
    if (view == nil){
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else{
        label = (UILabel *)[view viewWithTag:1];
    }
    label.text = [self.segmentControl titleForSegmentAtIndex:index];
    
    return view;
}
- (CGSize)swipeViewItemSize:(SwipeView *)swipeView{
    return self.swipeView.bounds.size;
}
-(void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate{
    swipeFlag = 1;
}
-(void)swipeViewDidScroll:(SwipeView *)swipeView{
    if (swipeFlag == 1){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .1 * NSEC_PER_SEC), dispatch_get_main_queue(),^{
            [self.segmentControl setSelectedSegmentIndex:swipeView.currentPage];
            swipeFlag = 0;
        });
    }
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
    selectedIndex = (int)indexPath.row;
    [self performSegueWithIdentifier:@"conversation" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"conversation"]){
        ConversationViewController *vc = [segue destinationViewController];
        vc.icon = [friends getObject:1 fromRow:selectedIndex];
        vc.name = [friends getObject:2 fromRow:selectedIndex];
    }
}

@end
