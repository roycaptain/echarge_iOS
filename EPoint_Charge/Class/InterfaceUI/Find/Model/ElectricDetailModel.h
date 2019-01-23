//
//  ElectricDetailModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/13.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ElectricDetailModel : NSObject

@property(nonatomic,copy)NSString *times; // 时间段
@property(nonatomic,copy)NSString *unitPrice; // 单价
@property(nonatomic,copy)NSString *service; // 服务费
@property(nonatomic,copy)NSString *actualFee; // 实际费用

+(instancetype)modelWithDictionary:(NSArray *)data withIndex:(NSInteger)index;

@end
