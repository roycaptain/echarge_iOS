//
//  DeviceModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/10.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 充电枪 模型
 */
#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject

@property(nonatomic,assign)NSInteger deviceid; // id
@property(nonatomic,copy)NSString *deviceName; // 充电枪名称
@property(nonatomic,copy)NSString *serialnum; // 充电站点

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
