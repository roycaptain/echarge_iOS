//
//  AroundCell.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/29.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartScoreView.h"

extern CGFloat const AroundCellXPoint; // x 坐标
extern CGFloat const AroundCellIconWidth;

@class AroundModel;

@interface AroundCell : UITableViewCell

@property(nonatomic,strong)UILabel *stationLabel; // 充电桩名称
@property(nonatomic,strong)UIImageView *parkImageView; // 停车图标
@property(nonatomic,strong)UILabel *parkFeeLabel; // 停车费
@property(nonatomic,strong)UIImageView *distanceImageView; // 距离图标
@property(nonatomic,strong)UILabel *distanceLabel; // 距离
// 地点
@property(nonatomic,strong)UIImageView *locationIcon;
@property(nonatomic,strong)UILabel *locationLabel;

//@property(nonatomic,strong)UIImageView *exchangeImageView; // 交流图标
//@property(nonatomic,strong)UILabel *exchnageLabel; // 交流
//@property(nonatomic,strong)UIImageView *directImageView; // 直流图标
//@property(nonatomic,strong)UILabel *directLabel; // 直流电
//@property(nonatomic,strong)StartScoreView *startScore; // 五星评分

@property(nonatomic,strong)UIButton *navItem; // 导航按钮

@property(nonatomic,strong)AroundModel *model;

@end
