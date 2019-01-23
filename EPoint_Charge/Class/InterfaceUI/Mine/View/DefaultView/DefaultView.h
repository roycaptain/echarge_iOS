//
//  DefaultView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/24.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 历史订单 我的收藏 我的消息 缺省页面
 */
#import <UIKit/UIKit.h>

@interface DefaultView : UIView

@property(nonatomic,strong)UIImageView *promptImageView;
@property(nonatomic,strong)UILabel *promptLabel;

+(DefaultView *)shareInstance;

-(void)setSuperView:(UIView *)superView withDefaultImageNamed:(NSString *)imageNamed withTitle:(NSString *)title;

@end
