//
//  LoginTextField.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 登陆模块的 输入框 （不带按钮）
 */
#import <UIKit/UIKit.h>

@interface LoginTextField : UIView

@property(nonatomic,strong)UITextField *textField; // 输入框
@property(nonatomic,strong)UILabel *underLine; // 下划线

// 设置 placeholder
-(void)setTextFieldPlaceHolder:(NSString *)placeholder;

@end
