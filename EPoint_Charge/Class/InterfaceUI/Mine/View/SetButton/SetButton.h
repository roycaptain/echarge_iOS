//
//  SetButton.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 类似于 TableView cell 的按钮
 */
#import <UIKit/UIKit.h>

@interface SetButton : UIButton

@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIImageView *accessoryImage;

-(void)setSetButtonHeadTitle:(NSString *)title;
-(void)setSetButtonDetailTitle:(NSString *)detailLabel;
-(void)setSetButtonAccessoryImageView;

@end
