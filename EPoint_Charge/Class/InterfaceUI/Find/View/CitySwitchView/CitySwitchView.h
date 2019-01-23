//
//  CitySwitchView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/2.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitySwitchDelegate<NSObject>

// 点击定位按钮
-(void)citySwitchLocationWithName;

// 城市按钮
-(void)cityItemClickWithCity:(NSString *)city;

@end

@interface CitySwitchView : UIView

@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *itemView;
@property(nonatomic,strong)UIButton *locationItem;

@property(nonatomic,assign)NSUInteger itemNum; // 按钮的个数

@property(nonatomic,weak)id<CitySwitchDelegate> delegate;

// 设置标题
-(void)setTitleLabelWithText:(NSString *)title;

// 设置按钮
-(void)setCityItemWithItemArray:(NSArray *)items;

// 设置定位按钮
-(void)setLocationItem;

@end
