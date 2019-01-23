//
//  AroundModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/3.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 充电桩数据模型
 */
#import <Foundation/Foundation.h>

@interface AroundModel : NSObject

@property(nonatomic,copy)NSString *stationName; // 站点名称
@property(nonatomic,copy)NSString *parkFee; // 停车费
@property(nonatomic,copy)NSString *electFee; // 电费
@property(nonatomic,copy)NSString *serviceFee; // 服务费
@property(nonatomic,copy)NSString *place; // 地点
@property(nonatomic,copy)NSString *carrier; // 运营商
@property(nonatomic,copy)NSString *distance; // 距离
@property(nonatomic,assign)NSInteger startCount; // 评分五星的个数
@property(nonatomic,copy)NSAttributedString *direct; // 直流电
@property(nonatomic,copy)NSString *exchange; // 交流电

@property(nonatomic,assign)NSInteger stationID; // 站点id
@property(nonatomic,assign)NSInteger collectStatus; // 是否收藏
@property(nonatomic,assign)BOOL isSupportOrder; // 是否可以预约

@property(nonatomic,strong)NSDictionary *data; // 每个站点的数据

// 坐标
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *longitude;

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
