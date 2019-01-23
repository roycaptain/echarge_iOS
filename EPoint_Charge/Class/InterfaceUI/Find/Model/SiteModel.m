//
//  SiteModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/11.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "SiteModel.h"

@implementation SiteModel

+(instancetype)modelWithAMapPOI:(AMapPOI *)poi
{
    SiteModel *model = [[self alloc] init];
    
    model.title = poi.name;
    model.detailTitle = poi.address;
    model.latitude = poi.location.latitude;
    model.longitude = poi.location.longitude;
    
    model.itemWidth = [GeneralSize calculateStringWidth:model.title withFontSize:12.0f withStringHeight:12.0f];
    model.itemHeight = 25.0f;
    
    return model;
}

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    SiteModel *model = [[self alloc] init];
    
    model.title = dictionary[@"title"];
    model.detailTitle = dictionary[@"detailTitle"];
    model.latitude = [dictionary[@"latitude"] doubleValue];
    model.longitude = [dictionary[@"longitude"] doubleValue];
    
    model.itemWidth = [dictionary[@"itemWidth"] floatValue];
    model.itemHeight = [dictionary[@"itemHeight"] floatValue];
    
    return model;
}

@end
