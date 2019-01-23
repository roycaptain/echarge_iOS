//
//  ResultStatusView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultStatusView : UIView

@property(nonatomic,strong)UIImageView *statusImage;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *detailLabel;

-(void)setStatusImageViewWithImageName:(NSString *)imageName;
-(void)setStatusTitle:(NSString *)title;
-(void)setStatusDetailTitle:(NSString *)detailTitle;

@end
