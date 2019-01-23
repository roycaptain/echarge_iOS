//
//  HistoryOrder.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "HistoryOrder.h"

@implementation HistoryOrder

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    HistoryOrder *model = [[self alloc] init];
    
    NSString *orderCode = dictionary[@"orderCode"]; // 订单编号
    NSString *chargeEnergy = dictionary[@"chargeEnergy"] ? dictionary[@"chargeEnergy"] : @"0";// 电量
    NSString *totalCost = dictionary[@"totalCost"] ? dictionary[@"totalCost"] : @"0";// 费用
    NSString *stationName = dictionary[@"stationName"];// 站点名称
    NSString *startTime = dictionary[@"startTime"];// 开始时间
    NSInteger min = [dictionary[@"chargeSeconds"] integerValue] / 60;
    
    model.orderNum = orderCode;
    // 订单信息
    NSString *describe = @"订单信息: ";
    NSString *info = [NSString stringWithFormat:@"电量%@度, 计%@元",chargeEnergy,totalCost];
    model.orderInfo = [self setOrderInfoText:describe andInfoText:info];
    // 充电站点
    model.chargeStation = [NSString stringWithFormat:@"充电站点:%@",stationName];
    // 时间
    model.date = [NSString stringWithFormat:@"%@ | %ld分钟",startTime,(long)min];
    
    return model;
}

+(NSAttributedString *)setOrderInfoText:(NSString *)describe andInfoText:(NSString *)info
{
    NSMutableAttributedString *attriDescribe = [[NSMutableAttributedString alloc] initWithString:describe];
    [attriDescribe setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, attriDescribe.length)];
    NSMutableAttributedString *attriInfo = [[NSMutableAttributedString alloc] initWithString:info];
    [attriInfo setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#2FCDC2"]} range:NSMakeRange(0, attriInfo.length)];
    [attriDescribe appendAttributedString:attriInfo];
    
    NSAttributedString *attributedText = attriDescribe;
    return attributedText;
}

@end
