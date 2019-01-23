//
//  UserLocationManager.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/3.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 用户地理位置 单例存储
 */
#import <Foundation/Foundation.h>

@interface UserLocationManager : NSObject

+(UserLocationManager *)shareInstance;

/*
 获取用户的经纬度
 */
-(void)setUserLocationWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude;

/*
 获取用户的位置
 经度 和 纬度
 */
-(NSString *)getUserLocationWithLatitude;

-(NSString *)getUserLocationWithLongitude;

@end
