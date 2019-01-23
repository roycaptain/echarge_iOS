//
//  DeviceModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/10.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    DeviceModel *model = [[self alloc] init];
    
    model.deviceid = [dictionary[@"deviceid"] integerValue]; // id
    model.deviceName = dictionary[@"deviceName"]; // 充电枪名称
    model.serialnum = dictionary[@"deviceSerialNum"]; // 充电站点
    
    return model;
}

@end
