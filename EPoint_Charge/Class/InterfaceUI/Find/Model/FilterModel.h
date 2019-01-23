//
//  FilterModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/6.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject

+(FilterModel *)shareInstance;

@property(nonatomic,strong)NSArray *stations;
@property(nonatomic,strong)NSArray *distances;


-(NSArray *)setFilterArray:(NSArray *)data;

@end
