//
//  RechargeView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSUInteger const ColCount; //每行的个数
extern CGFloat const ItemHeight; // 按钮的高度
extern CGFloat const BetweenSpace; // 间距
extern NSString *const NormalColor; // 正常颜色
extern NSString *const SelectColor; // 选中颜色

@protocol RechargeViewDelegate<NSObject>

// 点击事件
-(void)rechargeItemClickWithTitle:(NSString *)title;

@end

@interface RechargeView : UIView

@property(nonatomic,strong)UIButton *selectItem;

@property(nonatomic,weak)id<RechargeViewDelegate> delegate;

@end
