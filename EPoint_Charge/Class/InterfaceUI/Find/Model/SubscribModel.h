//
//  SubscribModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/4.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribModel : NSObject

@property(nonatomic,copy)NSString *deviceID; // 电桩ID
@property(nonatomic,copy)NSString *deviceSerialNum;
@property(nonatomic,copy)NSString *deviceName; // 电桩名称
@property(nonatomic,copy)NSString *parkFee; // 停车费
@property(nonatomic,copy)NSString *place; // 地点
@property(nonatomic,copy)NSString *distance; // 距离
@property(nonatomic,assign)NSInteger isSupportOrder; // 是否可以预约

// 坐标
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *longitude;

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary withInfo:(NSDictionary *)info;

@end

