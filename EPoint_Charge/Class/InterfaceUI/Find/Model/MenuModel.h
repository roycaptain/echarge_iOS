//
//  MenuModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property(nonatomic,copy)NSString *title;

+(NSArray *)initSiteTypeData;

+(NSArray *)initCarriersData;

@end
