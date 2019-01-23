//
//  PolyTypeController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/14.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import "MainViewController.h"

extern NSString *const CollectCellIdentifier;
extern NSString *const GunTypeIdentifier;
extern NSString *const BatteryTypeIdentifier;
extern NSString *const ColtageTypeIdentifier;

@interface PolyTypeController : MainViewController

@property(nonatomic,assign)NSInteger type; // 类型
@property(nonatomic,copy)NSString *deviceSerialNum;  // 设备序列号

@end
