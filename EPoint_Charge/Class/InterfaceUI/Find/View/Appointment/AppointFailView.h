//
//  AppointFailView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/5.
//  Copyright © 2018 dddgong. All rights reserved.
//

/*
 预约启动c失败弹出框
 */
#import <UIKit/UIKit.h>

typedef void(^RightItemBlock)(void);

@interface AppointFailView : UIView

@property(nonatomic,copy)RightItemBlock rightBlock;

-(instancetype)initFailWith:(NSString *)title withMessage:(NSString *)message withLeftItemTitle:(NSString *)leftTitle withRightItemTitle:(NSString *)rightTitle withRightBlock:(void(^)(void))rightBlock;

-(void)show;

@end
