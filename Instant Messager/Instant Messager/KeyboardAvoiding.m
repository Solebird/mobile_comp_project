//
//  KeyboardAvoiding.m
//  ShopDaily
//
//  Created by Thomas Cheung on 23/1/2017.
//  Copyright © 2017 Thomas Cheung. All rights reserved.
//

#import "KeyboardAvoiding.h"

@implementation KeyboardAvoiding{
    float keyboardHeight;
    float focusedTextFieldPosY;
}
@synthesize viewToScroll;
+ (KeyboardAvoiding *) getInstance{
    static KeyboardAvoiding *_default = nil;
    if (_default == nil){ //init
        _default = [[KeyboardAvoiding alloc] init];
    }
    return _default;
}

-(void)setKeyboardAvoidingForView:(UIScrollView*)view{
    viewToScroll = view;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardAvoiding{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    if (keyboardHeight == 0){
        keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        [viewToScroll setContentSize:CGSizeMake(viewToScroll.frame.size.width, viewToScroll.contentSize.height+keyboardHeight)];
        
        if (focusedTextFieldPosY > viewToScroll.frame.size.height-keyboardHeight){
            [UIView animateWithDuration:.5f animations:^{} completion:^(BOOL finished){
                [viewToScroll setContentOffset:CGPointMake(0, focusedTextFieldPosY-20) animated:YES];
            }];
        }
    }
}
-(void)keyboardWillHide:(NSNotification *)notification{
    [viewToScroll setContentSize:CGSizeMake(viewToScroll.frame.size.width, viewToScroll.contentSize.height-keyboardHeight)];
    keyboardHeight = 0;
}

-(void)setAutoScrollForTextField:(UITextField*)textField{
    [textField setDelegate:self];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    focusedTextFieldPosY = [textField convertPoint:CGPointZero toView:viewToScroll].y;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    focusedTextFieldPosY = 0;
}
@end
