//
//  SubscribModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/4.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import "SubscribModel.h"

@implementation SubscribModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary withInfo:(NSDictionary *)info
{
    SubscribModel *model = [[self alloc] init];
    
    model.deviceID = [NSString stringWithFormat:@"%@",dictionary[@"deviceId"]];
    model.deviceName = [NSString stringWithFormat:@"%@",dictionary[@"deviceName"]];
    model.deviceSerialNum = [NSString stringWithFormat:@"%@",dictionary[@"deviceSerialNum"]];
    model.parkFee = info[@"parkFee"];
    model.distance = info[@"distance"];
    model.place = info[@"place"];
    model.latitude = info[@"latitude"];
    model.longitude = info[@"longitude"];
    model.isSupportOrder = [info[@"isSupportOrder"] integerValue];
    
    return model;
}

@end
