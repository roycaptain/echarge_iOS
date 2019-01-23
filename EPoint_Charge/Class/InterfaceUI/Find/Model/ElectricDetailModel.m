//
//  ElectricDetailModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/13.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ElectricDetailModel.h"

@implementation ElectricDetailModel

+(instancetype)modelWithDictionary:(NSArray *)data withIndex:(NSInteger)index
{
    NSDictionary *currentDic = data[index];
    
    NSString *endTime = currentDic[@"endTime"];
    double unitPrice = [currentDic[@"formula"] doubleValue] / 100;
    double service = [currentDic[@"serviceFormula"] doubleValue] / 100;
    double actualFee = unitPrice + service;
    
    NSString *times;
    if (index == 0) {
        times = [NSString stringWithFormat:@"00:00-%@",currentDic[@"endTime"]];
    } else {
        NSDictionary *lastDic = data[index - 1];
        NSString *startTime = lastDic[@"endTime"];
        times = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
    }
    
    ElectricDetailModel *model = [[self alloc] init];
    
    model.times = times;
    model.unitPrice = [NSString stringWithFormat:@"%.2f",unitPrice];
    model.service = [NSString stringWithFormat:@"%.2f",service];
    model.actualFee = [NSString stringWithFormat:@"%.2f",actualFee];
    
    return model;
}

@end
