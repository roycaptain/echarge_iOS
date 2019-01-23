//
//  SelectVoltageController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/28.
//  Copyright © 2018 dddgong. All rights reserved.
//

/*
 选择电压
 */
#import "MainViewController.h"

extern NSString *const VoltageCellIdentifier;

@interface SelectVoltageController : MainViewController

@property(nonatomic,copy)NSString *deviceSerialNum; // 设备序列号
@property(nonatomic,copy)NSString *childDeviceSerialNum; // 子设备序列号

@end
