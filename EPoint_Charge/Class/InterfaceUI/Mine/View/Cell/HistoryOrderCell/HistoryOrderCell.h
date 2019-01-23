//
//  HistoryOrderCell.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const HistoryOrderCellXPoint; // x 坐标

@class HistoryOrder;

@interface HistoryOrderCell : UITableViewCell

@property(nonatomic,strong)UIView *bjView; // 背景
@property(nonatomic,strong)UIView *point;
@property(nonatomic,strong)UILabel *orderNum; // 订单编号
@property(nonatomic,strong)UILabel *orderInfo; // 订单信息
@property(nonatomic,strong)UILabel *chargeStation; // 充电站点
@property(nonatomic,strong)UILabel *date; // 时间

@property(nonatomic,strong)HistoryOrder *model;

@end
