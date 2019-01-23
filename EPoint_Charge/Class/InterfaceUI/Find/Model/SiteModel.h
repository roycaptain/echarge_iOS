//
//  SiteModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/11.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface SiteModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *detailTitle;
// 经纬度
@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat longitude;

// 历史搜索每个item的宽高
@property(nonatomic,assign)CGFloat itemWidth;
@property(nonatomic,assign)CGFloat itemHeight;

+(instancetype)modelWithAMapPOI:(AMapPOI *)poi;

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
