//
//  ChargeModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/10.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 正在充电 模型
 充电电量 电压 电功率 进度 订单状态
 */
#import <Foundation/Foundation.h>

@interface ChargeModel : NSObject

@property(nonatomic,copy)NSString *orderStatus; // CHARGE 充电中 FINISH 充电完成
@property(nonatomic,copy)NSAttributedString *voltage; // 充电电压
@property(nonatomic,copy)NSAttributedString *power; //电功率
@property(nonatomic,copy)NSAttributedString *current; // 电量
@property(nonatomic,copy)NSString *soc; //充电进度

@property(nonatomic,copy)NSString *deviceSerialNum;
@property(nonatomic,copy)NSString *childDeviceSerialNum;

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
