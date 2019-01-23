//
//  MAccountView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/22.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 我的 模块首页 账户视图
 */
#import <UIKit/UIKit.h>

@protocol MAccountDelegate<NSObject>

// 充值
-(void)accountRecharge;

// 退款
-(void)accountReFund;

@end

@interface MAccountView : UIView

@property(nonatomic,strong)UILabel *accountLabel; // 账户余额
@property(nonatomic,strong)UILabel *moneyLabel; // 金额
@property(nonatomic,strong)UIButton *recharge; // 充值
@property(nonatomic,strong)UIButton *refund; // 退款

@property(nonatomic,weak)id<MAccountDelegate> delegate;

@end
