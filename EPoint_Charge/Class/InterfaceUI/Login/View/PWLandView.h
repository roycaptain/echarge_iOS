//
//  PWLandView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 密码登陆模块
 */
#import <UIKit/UIKit.h>
#import "LoginTextField.h"
#import "TextFieldWithSecuryItem.h"

@interface PWLandView : UIView

@property(nonatomic,strong)LoginTextField *accountField; // 账号输入
@property(nonatomic,strong)TextFieldWithSecuryItem *passWordField; // 密码输入

@end
