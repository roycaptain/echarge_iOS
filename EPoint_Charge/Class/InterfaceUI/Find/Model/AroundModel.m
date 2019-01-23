//
//  AroundModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/3.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "AroundModel.h"

@implementation AroundModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    AroundModel *model = [[self alloc] init];
    // 站点名称
    model.stationName = dictionary[@"stationName"];
    // 停车费
    model.parkFee = @"停车费: --";
    // 电费
    model.electFee = @"电费: 2.0元/度";
    // 地点
    model.place = dictionary[@"address"];
    // 距离
    float distance = [dictionary[@"distance"] floatValue] / 1000;
    NSString *range = (distance > 1) ? [NSString stringWithFormat:@"距离: %.2fkm",distance] : [NSString stringWithFormat:@"距离: %@m",dictionary[@"distance"]];
    model.distance = range;
    // 五星个数
    model.startCount = 2;
    // 直流电
    NSString *deviceFreeCountTotal = [NSString stringWithFormat:@"%@",dictionary[@"deviceFreeCountTotal"]];// 空闲
    NSString *deviceTotal = [NSString stringWithFormat:@"%@",dictionary[@"deviceTotal"]]; // 总数
    model.direct = [Common setFreeNumberWithText:deviceFreeCountTotal andSunmNumberWithText:deviceTotal];
    // 交流电
    model.exchange = @"直流: 空闲 8 / 总数 18";
    
    // 站点id
    model.stationID = [dictionary[@"stationId"] integerValue];
    // 是否收藏
    model.collectStatus = [dictionary[@"collectStatus"] integerValue];
    // 是否可以预约
    model.isSupportOrder = [dictionary[@"isSupportOrder"] integerValue] == 1 ? YES : NO;
    // 运营商
    model.carrier = @"国家电网";
    
    // 坐标
    model.latitude = dictionary[@"latitude"];
    model.longitude = dictionary[@"longitude"];
    
    model.data = dictionary;
    
    return model;
}

@end
