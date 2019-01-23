//
//  ChargeAnnotation.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/5.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>


@interface ChargeAnnotation : NSObject<MAAnnotation>

@property(nonatomic,assign) CLLocationCoordinate2D coordinate; // 坐标

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

@property(nonatomic,strong)NSArray *templateList; // 计费模版详情

@property(nonatomic,assign)NSInteger stationID; // 站点id
@property(nonatomic,assign)NSInteger collectStatus; // 是否收藏

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dict;

@end
