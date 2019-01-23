//
//  SubscribeSheetModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/4.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribeSheetModel : NSObject

@property(nonatomic,copy)NSString *deviceName; // 设备名称
@property(nonatomic,copy)NSString *parkFee; // 停车费
@property(nonatomic,copy)NSString *distance; // 距离
@property(nonatomic,copy)NSString *address; // 地点
@property(nonatomic,copy)NSString *startTime; // 预约开始时间
@property(nonatomic,copy)NSString *endTime; // 预约结束时间
@property(nonatomic,copy)NSString *deviceSerialNum; // 设备编号

// 经纬度
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *longitude;

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
