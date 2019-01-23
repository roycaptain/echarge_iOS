//
//  ElectricDetailCell.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/13.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ElectricDetailModel;

@interface ElectricDetailCell : UITableViewCell

@property(nonatomic,strong)UILabel *timeLabel; // 时间段
@property(nonatomic,strong)UILabel *unitLabel; // 单价
@property(nonatomic,strong)UILabel *serviceLabel; // 服务费
@property(nonatomic,strong)UILabel *actualLabel; // 实际费用

@property(nonatomic,strong)ElectricDetailModel *model;

@end
