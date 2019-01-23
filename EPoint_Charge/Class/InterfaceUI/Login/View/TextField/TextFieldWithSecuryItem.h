//
//  TextFieldWithSecuryItem.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 登陆模块 输入框 (带隐藏显示密码按钮)
 */
#import <UIKit/UIKit.h>

extern CGFloat const SecureItemWidth; // 按钮的宽度
extern CGFloat const SecureItemHeight; // 按钮的高度

@interface TextFieldWithSecuryItem : UIView

@property(nonatomic,strong)UITextField *textField; // 输入框
@property(nonatomic,strong)UILabel *underLine; // 下划线
@property(nonatomic,strong)UIButton *secureItem; // 隐藏显示密码按钮

// 设置 placeholder
-(void)setTextFieldPlaceHolder:(NSString *)placeholder;

@end
