//
//  UserLocationManager.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/3.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "UserLocationManager.h"

@interface UserLocationManager()

@property(nonatomic,copy)NSString *latitude; // 经度
@property(nonatomic,copy)NSString *longitude; // 纬度

@end

@implementation UserLocationManager

+ (UserLocationManager *)shareInstance
{
    static UserLocationManager *singleton = nil;
    
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
        self.latitude = [[NSString alloc] init];
        self.longitude = [[NSString alloc] init];
    }
    return self;
}

/*
 获取用户的经纬度
 */
-(void)setUserLocationWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude
{
    self.latitude = latitude;
    self.longitude = longitude;
}

/*
 获取用户的位置
 经度 和 纬度
 */
-(NSString *)getUserLocationWithLatitude
{
    return self.latitude;
}

-(NSString *)getUserLocationWithLongitude
{
    return self.longitude;
}

@end
