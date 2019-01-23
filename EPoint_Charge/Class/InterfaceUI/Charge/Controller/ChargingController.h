//
//  ChargingController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/17.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 充电中模块
 */
#import "MainViewController.h"

extern CGFloat const ChargeElectWidth; // 充电文本宽度
extern CGFloat const ChargeElectHeight; //充电文本高度
extern CGFloat const LabelUpDownSapce; // 文本上下间隔
extern NSString *const CHARGE; // 充电中
extern NSString *const FINISH; // 充电完成

@interface ChargingController : MainViewController

@property(nonatomic,copy)NSString *deviceSerialNum; // 设备序列号
@property(nonatomic,copy)NSString *childDeviceSerialNum; // 设备子部件(枪号序列号)

@end
