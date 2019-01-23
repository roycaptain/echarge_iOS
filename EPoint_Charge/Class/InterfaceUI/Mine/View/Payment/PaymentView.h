//
//  PaymentView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentItem.h"

@protocol PaymentViewDelegate<NSObject>

// 点击事件
-(void)clickWithPaymentItem:(PaymentType)payType;

@end

@interface PaymentView : UIView

@property(nonatomic,strong)PaymentItem *alipayItem;
@property(nonatomic,strong)UILabel *underLine;
@property(nonatomic,strong)PaymentItem *wechatItem;

@property(nonatomic,strong)PaymentItem *selectItem; // 选中的支付方式

@property(nonatomic,weak)id<PaymentViewDelegate> delegate;

@end
