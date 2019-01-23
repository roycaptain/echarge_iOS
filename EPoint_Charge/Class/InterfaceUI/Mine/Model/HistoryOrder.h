//
//  HistoryOrder.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryOrder : NSObject

@property(nonatomic,copy)NSString *orderNum; // 订单编号
@property(nonatomic,copy)NSAttributedString *orderInfo; // 订单信息
@property(nonatomic,copy)NSString *chargeStation; // 充电站点
@property(nonatomic,copy)NSString *date; // 日期

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
