//
//  DurationController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/14.
//  Copyright © 2019 dddgong. All rights reserved.
//

/*
 选择时长
 */
#import "MainViewController.h"

extern NSString *const DurationCellIdentifier;

@interface DurationController : MainViewController

@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)NSDictionary *KYDictionary; // dtype为3的参数

@end
