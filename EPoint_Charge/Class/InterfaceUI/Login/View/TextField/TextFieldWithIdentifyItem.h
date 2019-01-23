//
//  TextFieldWithIdentifyItem.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 注册登陆模块 输入框(带验证码按钮)
 */
#import <UIKit/UIKit.h>

@protocol TextFieldWithIdentifyItemDelegate<NSObject>

// 验证码按钮点击事件
-(void)TextFieldWithIdentifyItemClick;

@end

extern CGFloat const IdentifyItemWidth; // 按钮宽度
extern CGFloat const IdentifyItemHeight; // 按钮高度

@interface TextFieldWithIdentifyItem : UIView

@property(nonatomic,strong)UITextField *textField; // 输入框
@property(nonatomic,strong)UILabel *underLine; // 下划线
@property(nonatomic,strong)UIButton *identifyItem; // 获取验证码

@property(nonatomic,strong)id<TextFieldWithIdentifyItemDelegate> delegate;

// 设置 placeholder
-(void)setTextFieldPlaceHolder:(NSString *)placeholder;

@end
