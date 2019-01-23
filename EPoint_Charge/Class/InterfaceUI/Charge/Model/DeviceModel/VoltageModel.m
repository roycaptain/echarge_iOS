//
//  VoltageModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/28.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "VoltageModel.h"

@implementation VoltageModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    VoltageModel *model = [[self alloc] init];
    
    model.name = dictionary[@"name"];
    model.value = dictionary[@"value"];
    
    return model;
}

@end
