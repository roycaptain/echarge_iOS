//
//  PolyTypeModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/14.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import "PolyTypeModel.h"

@implementation PolyTypeModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    PolyTypeModel *model = [[self alloc] init];
    
    model.name = [NSString stringWithFormat:@"%@",dictionary[@"deviceName"]];
    model.value = [NSString stringWithFormat:@"%@",dictionary[@"deviceSerialNum"]];
    
    return model;
}

@end
