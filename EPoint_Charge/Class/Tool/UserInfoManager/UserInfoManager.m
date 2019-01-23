//
//  UserInfoManager.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/1.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "UserInfoManager.h"

NSString *const UserInfoPhoneNum = @"PhoneNumOfUserInfo"; // 用户手机号
NSString *const UserInfoAccessToken = @"AccessToken"; // 访问令牌
NSString *const UserLocationCity = @"LocationCity"; // 用户所在城市
NSString *const UserLatitude = @"UserLatitude";
NSString *const UserLongitude = @"UserLongitude";

@interface UserInfoManager()

@property(nonatomic,strong)NSUserDefaults *defaults;

@end

@implementation UserInfoManager

+(UserInfoManager *)shareInstance
{
    static UserInfoManager *singleton = nil;
    
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
        self.defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

/*
 存储用户手机号 访问令牌
 @param NSString *phoneNum
 @param NSString *accessToken
 */
-(BOOL)saveUserInfoPhoneNum:(NSString *)phoneNum andAccessToken:(NSString *)accessToken
{
    [self.defaults setObject:phoneNum forKey:UserInfoPhoneNum];
    [self.defaults setObject:accessToken forKey:UserInfoAccessToken];
    return [self.defaults synchronize];
}

/*
 获取用户手机号
 return NSString *phoneNum
 */
-(NSString *)achieveUserInfoPhoneNum
{
    return [self.defaults objectForKey:UserInfoPhoneNum];
}

/*
 获取用户访问令牌
 return NSString *accessToken
 */
-(NSString *)achiveUserInfoAccessToken
{
    return [self.defaults objectForKey:UserInfoAccessToken];
}

/*
 清除用户手机号 和 访问令牌的存储 退出登录时使用
 */
-(void)loginOut
{
    NSDictionary *dictionary = [self.defaults dictionaryRepresentation];
    for (id key in dictionary) {
        [self.defaults removeObjectForKey:key];
    }
    [self.defaults synchronize];
}

/*
 保存 用户所在城市
 */
-(BOOL)setUserLocationCity:(NSString *)cityName
{
    [self.defaults setObject:cityName forKey:UserLocationCity];
    return [self.defaults synchronize];
}

/*
 获取用户所在城市
 */
-(NSString *)getUserLocationCity
{
    NSString *city = [self.defaults objectForKey:UserLocationCity];
    return city;
}

/*
 用户地理位置信息存储
 */
-(void)saveUserLocationWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude
{
    [self.defaults setObject:latitude forKey:UserLatitude];
    [self.defaults setObject:longitude forKey:UserLongitude];
    [self.defaults synchronize];
}

-(NSString *)getUserLocationWithLatitude
{
    return [self.defaults objectForKey:UserLatitude];
}

-(NSString *)getUserLocationWithLongitude
{
    return [self.defaults objectForKey:UserLongitude];
}

-(BOOL)isLocation
{
    NSString *latitude = [self getUserLocationWithLongitude];
    NSString *longitude = [self getUserLocationWithLongitude];
    if (latitude && longitude) {
        return YES;
    }
    return NO;
}

/*
 储存用户是否成功开启充电的状态
 */
-(void)saveUserStartChargeStatus:(BOOL)status
{
    NSNumber *number = [NSNumber numberWithBool:status];
    [self.defaults setObject:number forKey:@"ChargeStatus"];
    [self.defaults synchronize];
}

-(NSNumber *)getUserChargeStatus
{
    return [self.defaults objectForKey:@"ChargeStatus"];
}

@end
