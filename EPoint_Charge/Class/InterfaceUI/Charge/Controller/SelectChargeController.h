//
//  SelectChargeController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/8.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 选择充电枪充电
 */
#import "MainViewController.h"

extern NSString *const ChargeCellIdentifier;

@interface SelectChargeController : MainViewController

@property(nonatomic,copy)NSString *deviceSerialNum;  // 设备序列号

@end
