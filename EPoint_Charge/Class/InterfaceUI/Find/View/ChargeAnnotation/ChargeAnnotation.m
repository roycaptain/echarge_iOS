//
//  ChargeAnnotation.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/5.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ChargeAnnotation.h"

@implementation ChargeAnnotation

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // 坐标
        self.coordinate = CLLocationCoordinate2DMake([dictionary[@"latitude"] doubleValue], [dictionary[@"longitude"] doubleValue]);
        
        // 站点名称
        self.stationName = dictionary[@"stationName"];
        // 停车费
        self.parkFee = @"停车费: --";
        // 电费服务费
        [self setElectFeeAndserviceFeeWith:dictionary[@"templateList"]];
        // 地点
        self.place = dictionary[@"address"];
        // 距离
        float distance = [dictionary[@"distance"] floatValue] / 1000;
        NSString *range = (distance > 1) ? [NSString stringWithFormat:@"距离: %.2fkm",distance] : [NSString stringWithFormat:@"距离: %@m",dictionary[@"distance"]];
        self.distance = range;
        // 直流电
        NSString *deviceFreeCountTotal = [NSString stringWithFormat:@"%@",dictionary[@"deviceFreeCountTotal"]];// 空闲
        NSString *deviceTotal = [NSString stringWithFormat:@"%@",dictionary[@"deviceTotal"]]; // 总数
        self.direct = [Common setFreeNumberWithText:deviceFreeCountTotal andSunmNumberWithText:deviceTotal];
        // 交流电
        self.exchange = [NSString stringWithFormat:@"直流: 空闲 %@ / 总数 %@",deviceFreeCountTotal,deviceTotal]; // @"直流: 空闲 8 / 总数 18"
        // 站点id
        self.stationID = [dictionary[@"stationId"] integerValue];
        // 是否收藏
        self.collectStatus = [dictionary[@"collectStatus"] integerValue];
        // 运营商
        self.carrier = dictionary[@"companyName"];
        
        // 计费模版详情
        self.templateList = dictionary[@"templateList"];
        
        
        
        
    }
    return self;
}

-(void)setElectFeeAndserviceFeeWith:(NSArray *)templateList
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [dateComponent hour]; // 获取当前小时
    
    NSDictionary *template;
    for (NSInteger index = 0; index < templateList.count; index++) {
        template = templateList[index];
        NSInteger tHour = [template[@"endHour"] integerValue];
        if (hour <= tHour) {
            double unitPrice = [template[@"formula"] doubleValue] / 100;
            double service = [template[@"serviceFormula"] doubleValue] / 100;
            
            self.electFee = [NSString stringWithFormat:@"电费: %.2f元/度",unitPrice]; // 电费
            self.serviceFee = [NSString stringWithFormat:@"服务费: %.2f元/度",service]; // 服务费
        }
    }
}

@end
