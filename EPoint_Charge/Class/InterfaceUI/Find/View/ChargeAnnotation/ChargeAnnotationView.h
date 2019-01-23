//
//  ChargeAnnotationView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

extern CGFloat const width; // 标注的宽度
extern CGFloat const height; // 标注的高度

@interface ChargeAnnotationView : MAAnnotationView

@property(nonatomic,strong)UIImageView *chargeView;

@end
