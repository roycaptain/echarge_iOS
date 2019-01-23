//
//  VoltageModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/28.
//  Copyright © 2018 dddgong. All rights reserved.
//

/*
 电压模型
 */
#import <Foundation/Foundation.h>

@interface VoltageModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *value;

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
