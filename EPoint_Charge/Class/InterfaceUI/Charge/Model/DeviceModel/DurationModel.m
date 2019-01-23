//
//  DurationModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/14.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import "DurationModel.h"

@implementation DurationModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    DurationModel *model = [[self alloc] init];
    
    model.name = dictionary[@"name"];
    model.value = dictionary[@"value"];
    
    return model;
}

@end
