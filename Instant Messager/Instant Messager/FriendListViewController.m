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
    NSMutableArray *friendList;
    
    int swipeFlag;
    
    int selectedIndex;
    
    NSMutableArray *highlightedIndexPath;
    bool showingOptionMenu;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initOptionMenu];
    [self initSegmentControl];
    [self initSwipeView];
    [self initFriendList];
}

-(void)initOptionMenu{
    self.optionMenuOffset.constant = 0;
    showingOptionMenu = false;
    highlightedIndexPath = [NSMutableArray array];
}
-(void)openOptionMenu{
    [self.optionMenu setHidden:NO];
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [self.optionMenu setFrame:CGRectMake(self.optionMenu.frame.origin.x, 0, self.optionMenu.frame.size.width, self.optionMenu.frame.size.height)];
    } completion:^(bool complete){
        showingOptionMenu = true;
    }];
}
-(void)closeOptionMenu{
    UITableView *tableView = [self.swipeView.currentItemView viewWithTag:1];
    for (NSIndexPath *indexPath in highlightedIndexPath) {
        [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor clearColor]];
    }
    [highlightedIndexPath removeAllObjects];
    
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [self.optionMenu setFrame:CGRectMake(self.optionMenu.frame.origin.x, -100, self.optionMenu.frame.size.width, self.optionMenu.frame.size.height)];
    } completion:^(bool complete){
        [self.optionMenu setHidden:YES];
        showingOptionMenu = false;
    }];
}

-(void)initSegmentControl{
    [self.segmentControl removeAllSegments];
    [self.segmentControl insertSegmentWithTitle:@"All" atIndex:0 animated:NO];
}

-(void)initSwipeView{
    swipeFlag = 0;
    [self.swipeView setDataSource:self];
    [self.swipeView setDelegate:self];
}

-(void)initFriendList{
    [[Global getInstance] showLoading:self.view];
    NSDictionary *param = @{@"userID":[User getInstance].userId};
    [[Global getInstance] createDataTask:@"showAllFriend" withParam:param withCompletionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }else{
            NSLog(@"ResponseObject: %@", responseObject);
            NSDictionary *status = [responseObject objectForKey:@"status"];
            if ([[status objectForKey:@"number"] intValue]==0){
                NSArray *data = [responseObject objectForKey:@"data"];
                
                TCTable *friends = [TCTable new];
                for (NSDictionary *friend in data) {
                    [friends addRecord:[friend objectForKey:@"userID"],[friend objectForKey:@"username"],[friend objectForKey:@"icon"],[friend objectForKey:@"passwordLock"],nil];
                }
                [friends printArray];

                friendList = [NSMutableArray array];
                [friendList addObject:friends];
                [self.swipeView reloadData];
            }else{
                [[Global getInstance] showOkAlertBox:[status objectForKey:@"message"] inVC:self];
            }
        }
        [[Global getInstance] hideLoading];
    }];
}


//SegmentControl --------------------------------------------------------------------------------
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
            [friendList addObject:[TCTable new]];
            [self.segmentControl insertSegmentWithTitle:title atIndex:index animated:YES];
            [self.segmentControl setSelectedSegmentIndex:index];
            [self.swipeView reloadData];
            [self.swipeView scrollToPage:index duration:.5];
        }else{
            [[Global getInstance] showOkAlertBox:@"Group title cannot be empty." inVC:self];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
//end of SegmentControl --------------------------------------------------------------------------------


//SwipeView --------------------------------------------------------------------------------
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    return self.segmentControl.numberOfSegments;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UITableView *tableView = nil;
    if (view == nil){
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //tableview init
        tableView = [[UITableView alloc] initWithFrame:self.swipeView.bounds style:UITableViewStylePlain];
        [tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [tableView setTag:1];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [tableView setRowHeight:80.0];
        
        //set long press recognizer
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        longPress.minimumPressDuration = .5; //seconds
        longPress.delegate = self;
        [tableView addGestureRecognizer:longPress];
        
        [tableView reloadData];
        [view addSubview:tableView];
    }else{
        tableView = (UITableView *)[view viewWithTag:1];
        [tableView reloadData];
    }
    return view;
}
- (CGSize)swipeViewItemSize:(SwipeView *)swipeView{
    return self.swipeView.bounds.size;
}
-(void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate{
    swipeFlag = 1;
}
-(void)swipeViewDidScroll:(SwipeView *)swipeView{ //delay bug need to solve *
    if (swipeFlag == 1){
        swipeFlag = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .1 * NSEC_PER_SEC), dispatch_get_main_queue(),^{
            [self.segmentControl setSelectedSegmentIndex:swipeView.currentPage];
            [(UITableView*)[[self.swipeView itemViewAtIndex:self.swipeView.currentItemIndex] viewWithTag:1] reloadData];
        });
    }
}
//end of SwipeView --------------------------------------------------------------------------------


//TableView --------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(TCTable*)[friendList objectAtIndex:self.segmentControl.selectedSegmentIndex] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    TCTable *friends = [friendList objectAtIndex:self.segmentControl.selectedSegmentIndex];
    
    UIImageView *img = [cell viewWithTag:1];
    NSString *imgStr = [NSString stringWithFormat:@"icon%@.jpg",[friends getObject:2 fromRow:indexPath.row]];
    [img setImage:[UIImage imageNamed:imgStr]];
    [img setBackgroundColor:[UIColor whiteColor]];
    [img setContentMode:UIViewContentModeScaleAspectFill];
    [[Global getInstance] setCircleImage:img];
    
    UILabel *name = [cell viewWithTag:2];
    [name setText:[friends getObject:1 fromRow:indexPath.row]];
    
    UIImageView *lock = [cell viewWithTag:3];
    if ([[friends getObject:3 fromRow:indexPath.row] isEqualToString:@"0"])
        [lock setHidden:NO];
    else
        [lock setHidden:YES];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row: %d", (int)indexPath.row);
    if (showingOptionMenu){
        if ([highlightedIndexPath containsObject:indexPath]){
            [highlightedIndexPath removeObject:indexPath];
            [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor clearColor]];
        }else{
            [highlightedIndexPath addObject:indexPath];
            [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor lightGrayColor]];
        }
    }else{
        selectedIndex = (int)indexPath.row;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"conversation" sender:self];
        });
    }
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gesture{
    UITableView *tableView = [self.swipeView.currentItemView viewWithTag:1];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:[gesture locationInView:tableView]];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil && gesture.state == UIGestureRecognizerStateBegan) {
        [highlightedIndexPath addObject:indexPath];
        NSLog(@"Long press row: %ld", indexPath.row);
        [self openOptionMenu];
        [cell setBackgroundColor:[UIColor lightGrayColor]];
    }
}
//end of TableView --------------------------------------------------------------------------------


//OptionMenu --------------------------------------------------------------------------------
- (IBAction)onClickAddToGroup:(id)sender {
    if (self.segmentControl.numberOfSegments > 1){
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add To Group" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
        for (int i=1; i<self.segmentControl.numberOfSegments; i++) {
            [actionSheet addButtonWithTitle:[self.segmentControl titleForSegmentAtIndex:i]];
        }
        [actionSheet showInView:self.view];
    }else{ //No group avaiable
        [[Global getInstance] showOkAlertBox:@"No available groups." inVC:self];
        [self closeOptionMenu];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)index {
    if (index != 0){
        NSLog(@"Clicked Group: %ld",index);
        TCTable *current_friends = [friendList objectAtIndex:self.segmentControl.selectedSegmentIndex];
        TCTable *target_friends = [friendList objectAtIndex:index];
        for (NSIndexPath *indexPath in highlightedIndexPath) {
            [target_friends addEntireRecord:[current_friends getRecord:indexPath.row]];
        }
        [friendList replaceObjectAtIndex:index withObject:target_friends];
        
        [self closeOptionMenu];
    }else{ //Cancel do nothing
    }
}

- (IBAction)onClickLockChat:(id)sender {
    TCTable *friends = [friendList objectAtIndex:self.segmentControl.selectedSegmentIndex];
    for (NSIndexPath *indexPath in highlightedIndexPath) {
        [friends updateField:3 fromRow:(int)indexPath.row withObject:@"1"];
    }
    UITableView *tableView = [self.swipeView.currentItemView viewWithTag:1];
    [tableView reloadData];
    [self closeOptionMenu];
}

- (IBAction)onClickDeleteFriend:(id)sender {
    [self closeOptionMenu];
}

- (IBAction)onClickClose:(id)sender {
    [self closeOptionMenu];
}
//end of OptionMenu --------------------------------------------------------------------------------


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TCTable *friends = [friendList objectAtIndex:self.segmentControl.selectedSegmentIndex];
    if ([segue.identifier isEqualToString:@"conversation"]){
        ConversationViewController *vc = [segue destinationViewController];
        vc.icon = [friends getObject:1 fromRow:selectedIndex];
        vc.name = [friends getObject:2 fromRow:selectedIndex];
    }
}

@end
