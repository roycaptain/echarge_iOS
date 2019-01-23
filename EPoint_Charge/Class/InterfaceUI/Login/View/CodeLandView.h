//
//  CodeLandView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 验证码登陆模块
 */
#import <UIKit/UIKit.h>
#import "LoginTextField.h"
#import "TextFieldWithIdentifyItem.h"

@protocol CodeLandViewDelegate<NSObject>

// 获取输入框内的值
-(void)codeLandViewIdentifyItemClick;

@end

@interface CodeLandView : UIView<TextFieldWithIdentifyItemDelegate>

@property(nonatomic,strong)LoginTextField *accountField; // 输入账号
@property(nonatomic,strong)TextFieldWithIdentifyItem *identifyField; // 输入验证码

@property(nonatomic,weak)id<CodeLandViewDelegate> delegate;

@end
