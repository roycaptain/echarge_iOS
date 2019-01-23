//
//  SubscribeSheetModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/4.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import "SubscribeSheetModel.h"

@implementation SubscribeSheetModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    SubscribeSheetModel *model = [[self alloc] init];
    
    model.deviceName = [NSString stringWithFormat:@"%@",dictionary[@"deviceInfo"][@"deviceName"]];
    model.parkFee = [NSString stringWithFormat:@"停车费: %@元",dictionary[@"orderInfo"][@"parkFee"]];
    CGFloat distance = [dictionary[@"stationInfo"][@"distance"] integerValue] / 1000.0;
    model.distance = [NSString stringWithFormat:@"距离: %.2fkm",distance];
    model.address = [NSString stringWithFormat:@"%@",dictionary[@"stationInfo"][@"addr"]];
    model.startTime = [NSString stringWithFormat:@"预约开始时间: %@",dictionary[@"orderInfo"][@"startTime"]];
    model.endTime = [NSString stringWithFormat:@"预约结束时间: %@",dictionary[@"endTime"]];
    model.deviceSerialNum = [NSString stringWithFormat:@"%@",dictionary[@"deviceInfo"][@"deviceSerialNum"]];
    model.latitude = [NSString stringWithFormat:@"%@",dictionary[@"stationInfo"][@"latitude"]];
    model.longitude = [NSString stringWithFormat:@"%@",dictionary[@"stationInfo"][@"longitude"]];
    
    return model;
}

@end
