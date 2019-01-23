//
//  PaymentItem.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentItem : UIButton

@property(nonatomic,strong)UIImageView *payIcon; // 图标
@property(nonatomic,strong)UILabel *payLabel;
@property(nonatomic,strong)UIImageView *selectIcon;

-(void)setPaymentItemPayIconWithImageNamed:(NSString *)imageNamed;
-(void)setPaymentItemPayTitleWithText:(NSString *)title;
-(void)setPaymentItemSelectIconWithImageNamed:(NSString *)imageNamed;

@end
