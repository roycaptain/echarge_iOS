//
//  RefundView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundView : UIView

@property(nonatomic,strong)UILabel *refundTip; // 退款金额label
@property(nonatomic,strong)UILabel *rmbLabel;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *underLine;
@property(nonatomic,strong)UILabel *balanceLabel; // 余额

// 设置余额
-(void)setAccountBalance:(NSString *)balance;

@end
