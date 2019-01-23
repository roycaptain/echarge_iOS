//
//  ChargeModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/10.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ChargeModel.h"

@implementation ChargeModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    ChargeModel *model = [[self alloc] init];
    
    NSString *voltageStr = [NSString stringWithFormat:@"%@",dictionary[@"voltage"]]; // 电压
    NSString *powerStr = [NSString stringWithFormat:@"%@",dictionary[@"power"]]; // 电功率
    NSString *currentStr = [NSString stringWithFormat:@"%@",dictionary[@"current"]]; // 充电电量
    
    // 订单状态
    model.orderStatus = [NSString stringWithFormat:@"%@",dictionary[@"orderStatus"]];
    // 充电电压
    model.voltage = [self setDifferenceStyleStringWithFirstPartString:@"充电电压: " withSecondPartString:voltageStr withThirdPartString:@"V"];
    // 充电功率
    model.power = [self setDifferenceStyleStringWithFirstPartString:@"充电功率: " withSecondPartString:powerStr withThirdPartString:@"W"];
    // 充电电量
    model.current = [self setDifferenceStyleStringWithFirstPartString:@"充电电量: " withSecondPartString:currentStr withThirdPartString:@"A"];
    // 充电进度
    model.soc = [NSString stringWithFormat:@"%@",dictionary[@"soc"]];
    
    model.deviceSerialNum = [NSString stringWithFormat:@"%@",dictionary[@"deviceSerialNum"]];
    model.childDeviceSerialNum = [NSString stringWithFormat:@"%@",dictionary[@"childDeviceSerialNum"]];
    
    return model;
}

#pragma mark private method
+(NSAttributedString *)setDifferenceStyleStringWithFirstPartString:(NSString *)firstPartString withSecondPartString:(NSString *)secondPartString withThirdPartString:(NSString *)thirdPartString
{
    NSMutableAttributedString *firstMutableAttributedStr = [[NSMutableAttributedString alloc] initWithString:firstPartString];
    [firstMutableAttributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#000000"]} range:NSMakeRange(0, firstMutableAttributedStr.length)];
    NSMutableAttributedString *secondMutableAttributedStr = [[NSMutableAttributedString alloc] initWithString:secondPartString];
    [secondMutableAttributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#13BBC9"]} range:NSMakeRange(0, secondMutableAttributedStr.length)];
    NSMutableAttributedString *thirdMutableAttributedStr = [[NSMutableAttributedString alloc] initWithString:thirdPartString];
    [thirdMutableAttributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#000000"]} range:NSMakeRange(0, thirdMutableAttributedStr.length)];
    [firstMutableAttributedStr appendAttributedString:secondMutableAttributedStr];
    [firstMutableAttributedStr appendAttributedString:thirdMutableAttributedStr];
    NSAttributedString *attributedText = [firstMutableAttributedStr mutableCopy];
    return attributedText;
}


@end
