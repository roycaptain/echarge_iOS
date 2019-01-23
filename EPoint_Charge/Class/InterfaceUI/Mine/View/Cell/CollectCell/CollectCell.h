//
//  CollectCell.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/24.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellNavItem.h"

extern CGFloat const CollectCellXPoint; // x坐标
extern CGFloat const UpDownSapce; // 上下间隔

@class CollectModel;

@interface CollectCell : UITableViewCell

@property(nonatomic,strong)UILabel *chargePoleLabel; //充电桩
// 停车
@property(nonatomic,strong)UIImageView *parkingImageView;
@property(nonatomic,strong)UILabel *parkingFeeLabel;
// 距离
@property(nonatomic,strong)UIImageView *distanceImageView;
@property(nonatomic,strong)UILabel *distanceLabel;
// 地点
@property(nonatomic,strong)UIImageView *placeImageView;
@property(nonatomic,strong)UILabel *placeLabel;
// 直流
@property(nonatomic,strong)UIImageView *directImageView;
@property(nonatomic,strong)UILabel *directLabel;

// 交流
@property(nonatomic,strong)UIImageView *exchangeImageView;
@property(nonatomic,strong)UILabel *exchangeLabel;

@property(nonatomic,strong)CellNavItem *navItem; // 导航

@property(nonatomic,strong)CollectModel *model;

@end
