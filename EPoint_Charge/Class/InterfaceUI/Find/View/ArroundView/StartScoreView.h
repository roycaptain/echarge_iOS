//
//  StartScoreView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/29.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 星级评价
 */
#import <UIKit/UIKit.h>

extern NSUInteger const StartNumber; // 五角星的个数

@interface StartScoreView : UIView

-(void)setScroeWithStartNumber:(NSInteger)number;

@end
