//
//  SubScribeListController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

/*
 预约列表
 */
#import "MainViewController.h"

@interface SubScribeListController : MainViewController

@property(nonatomic,copy)NSString *stationId; // 站点id
@property(nonatomic,copy)NSString *parkFee; // 停车费
@property(nonatomic,copy)NSString *distance; // 距离
@property(nonatomic,copy)NSString *location; // 地点
@property(nonatomic,assign)BOOL isSupportOrder; // 是否可以预约
// 坐标
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *longitude;

@end
