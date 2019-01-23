//
//  CollectModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/24.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CollectModel.h"

@implementation CollectModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    CollectModel *model = [[self alloc] init];
    // 充电桩名字
    model.chargePole = dictionary[@"stationName"];
    // 停车费
    model.parkingFee = @"停车费: --";
    // 距离
    float distance = [dictionary[@"distance"] floatValue] / 1000;
    NSString *range = (distance > 1) ? [NSString stringWithFormat:@"距离: %.2fkm",distance] : [NSString stringWithFormat:@"距离: %@m",dictionary[@"distance"]];
    model.distance = range;
    // 地点
    model.place = dictionary[@"address"];
    // 直流
    NSString *deviceFreeCountTotal = [NSString stringWithFormat:@"%@",dictionary[@"deviceFreeCountTotal"]];// 空闲
    NSString *deviceTotal = [NSString stringWithFormat:@"%@",dictionary[@"deviceTotal"]]; // 总数
    model.direct = [self setDifferentFontWithFirstText:@"空闲 " andSecondText:deviceFreeCountTotal andThirdText:@" / 总数 " andFourthText:deviceTotal];
    // 交流
    model.exchange = [self setDifferentFontWithFirstText:@"交流: 空闲 " andSecondText:@"1" andThirdText:@" / 总数 " andFourthText:@"9"];
    
    // 经纬度
    model.latitude = dictionary[@"latitude"];
    model.longitude = dictionary[@"longitude"];
    
    return model;
}


// 转换字体颜色
+(NSAttributedString *)setDifferentFontWithFirstText:(NSString *)firstString andSecondText:(NSString *)secondString andThirdText:(NSString *)thirdString andFourthText:(NSString *)fourthString
{
    UIFont *fontStyle = [UIFont fontWithName:@"PingFang SC" size:12.0f];
    UIColor *normalColor = [UIColor colorWithHexString:@"#999999"];
    UIColor *specialColor = [UIColor colorWithHexString:@"#02B1CD"];
    
    NSMutableAttributedString *firstAttriString = [[NSMutableAttributedString alloc] initWithString:firstString];
    [firstAttriString setAttributes:@{NSFontAttributeName : fontStyle,NSForegroundColorAttributeName : normalColor} range:NSMakeRange(0, firstAttriString.length)];
    NSMutableAttributedString *secondAttriString = [[NSMutableAttributedString alloc] initWithString:secondString];
    [secondAttriString setAttributes:@{NSFontAttributeName : fontStyle,NSForegroundColorAttributeName : specialColor} range:NSMakeRange(0, secondAttriString.length)];
    NSMutableAttributedString *thirdAttriString = [[NSMutableAttributedString alloc] initWithString:thirdString];
    [thirdAttriString setAttributes:@{NSFontAttributeName : fontStyle,NSForegroundColorAttributeName : normalColor} range:NSMakeRange(0, thirdAttriString.length)];
    NSMutableAttributedString *fourthAttriString = [[NSMutableAttributedString alloc] initWithString:fourthString];
    [fourthAttriString setAttributes:@{NSFontAttributeName : fontStyle,NSForegroundColorAttributeName : specialColor} range:NSMakeRange(0, fourthAttriString.length)];
    
    [firstAttriString appendAttributedString:secondAttriString];
    [firstAttriString appendAttributedString:thirdAttriString];
    [firstAttriString appendAttributedString:fourthAttriString];
    NSAttributedString *attributedString = firstAttriString;
    return attributedString;
}

@end
