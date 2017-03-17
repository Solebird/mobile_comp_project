//
//  KeyboardAvoiding.h
//  ShopDaily
//
//  Created by Thomas Cheung on 23/1/2017.
//  Copyright © 2017 Thomas Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface KeyboardAvoiding : NSObject <UITextFieldDelegate>

+ (KeyboardAvoiding *) getInstance;

@property UIScrollView *viewToScroll;

-(void)setKeyboardAvoidingForView:(UIScrollView*)view;
-(void)setAutoScrollForTextField:(UITextField*)textField;
-(void)removeKeyboardAvoiding;

@end
