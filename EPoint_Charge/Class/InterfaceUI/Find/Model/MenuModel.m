//
//  MenuModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

+(NSArray *)initSiteTypeData
{
    NSArray *originArray = @[@"全部站点",@"交流站点",@"直流站点"];
    NSMutableArray *mutableData = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < originArray.count; i++) {
        MenuModel *model = [[self alloc] init];
        model.title = originArray[i];
        [mutableData addObject:model];
    }
    return [mutableData copy];
}

+(NSArray *)initCarriersData
{
    NSArray *originArray = @[@"全部运营商",@"瑞兴充电",@"国家电网",@"星星充电",@"小易充电",@"点点电工",@"小二租车",@"深圳易充",@"其他"];
    NSMutableArray *mutableData = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < originArray.count; i++) {
        MenuModel *model = [[self alloc] init];
        model.title = originArray[i];
        [mutableData addObject:model];
    }
    return [mutableData copy];
}

@end
