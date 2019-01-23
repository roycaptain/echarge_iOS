//
//  PolyTypeModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/14.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PolyTypeModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *value;

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
