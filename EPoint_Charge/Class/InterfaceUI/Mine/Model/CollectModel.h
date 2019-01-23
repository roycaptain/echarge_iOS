//
//  CollectModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/24.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectModel : NSObject

@property(nonatomic,copy)NSString *chargePole; // 充电桩名字
@property(nonatomic,copy)NSString *parkingFee; // 停车费
@property(nonatomic,copy)NSString *distance; // 距离
@property(nonatomic,copy)NSString *place; // 地点
@property(nonatomic,copy)NSAttributedString *direct; // 直流
@property(nonatomic,copy)NSAttributedString *exchange; // 交流

// 经纬度
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *longitude;

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
