//
//  FilterModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/6.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "FilterModel.h"

@implementation FilterModel

+(FilterModel *)shareInstance
{
    static FilterModel *singleton = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.stations = @[@{@"stationName" : @"全部",@"stationType" : @""},
                          @{@"stationName" : @"交流站点",@"stationType" : @1},
                          @{@"stationName" : @"直流站点",@"stationType" : @2}];
        self.distances = @[@{@"title" : @"全部",@"startDistance" : @"",@"endDistance" : @""},
                           @{@"title" : @"1km以内",@"startDistance" : @0,@"endDistance" : @1},
                           @{@"title" : @"2-3km",@"startDistance" : @2,@"endDistance" : @3}];
    }
    return self;
}


-(NSArray *)setFilterArray:(NSArray *)data
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSDictionary *defaultDic = @{@"companyName" : @"全部",@"companyId" : @""};
    [temp addObject:defaultDic];
    for (NSDictionary *dictionary in data) {
        NSDictionary *dict = @{@"companyName" : dictionary[@"companyName"],@"companyId" : dictionary[@"companyId"]};
        [temp addObject:dict];
    }
    
    return @[self.stations,self.distances,[temp mutableCopy]];
}


@end
