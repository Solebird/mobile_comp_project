//
//  ConversationViewController.m
//  Instant Messager
//
//  Created by Thomas Cheung on 16/3/2017.
//
//

#import "ConversationViewController.h"

@interface ConversationViewController ()

@end

@implementation ConversationViewController{
    float keyboardHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    [self initData];
    [self setKeyboard];
}

-(void)setKeyboard{
    keyboardHeight = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)dismissKeyboard {
    [self.view endEditing:YES];
}
- (void)keyboardWillShow:(NSNotification *)notification{
    if (keyboardHeight == 0){
        keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        self.inputViewBottomMargin.constant = keyboardHeight;
        [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height)];
    }
}
-(void)keyboardWillHide:(NSNotification *)notification{
    self.inputViewBottomMargin.constant = 0;
    keyboardHeight = 0;
}

-(void)initData{
    [self.imgIcon setImage:[UIImage imageNamed:self.icon]];
    [self.imgIcon setBackgroundColor:[UIColor whiteColor]];
    [[Global getInstance] setCircleImage:self.imgIcon];
    
    [self.lbName setText:self.name];

    
    [self.tableView reloadData];
}

- (IBAction)onClickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;//[messages count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    if ([@"1" isEqualToString:@"1"])
        cellIdentifier = @"send";
    else
        cellIdentifier = @"receive";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *str = [NSString stringWithFormat:@"  %@  ",@"message"];
    
    UILabel *msg = [cell viewWithTag:1];
    [msg setText:str];
    [msg.layer setMasksToBounds:YES];
    [msg.layer setCornerRadius:5.0];
    [msg.layer setBorderWidth:1.0];
    [msg.layer setBorderColor:[UIColor blackColor].CGColor];
    if ([@"1" isEqualToString:@"1"])
        [msg setBackgroundColor:[UIColor lightGrayColor]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row: %d", (int)indexPath.row);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@""]){
    }
}

- (IBAction)onClickSend:(id)sender {
    NSString *str = self.tfInput.text;
    [self.tfInput setText:@""];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height)];
}

- (IBAction)onClickMenu:(id)sender {
    
}

@end
