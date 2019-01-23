//
//  ChangePWResultController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MainViewController.h"

@interface ChangePWResultController : MainViewController

@property(nonatomic,assign)ResultStatusType resultStatus;
@property(nonatomic,copy)NSString *alertText;

@end
