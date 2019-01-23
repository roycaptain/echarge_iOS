//
//  UserInfoManager.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/1.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const UserInfoPhoneNum; // 用户手机号
extern NSString *const UserInfoAccessToken; // 访问令牌
extern NSString *const UserLocationCity; // 用户所在城市
extern NSString *const UserLatitude;
extern NSString *const UserLongitude;

@interface UserInfoManager : NSObject

+(UserInfoManager *)shareInstance;

/*
 登陆时存储 手机号 和 令牌
 @param NSString *phoneNum
 */
-(BOOL)saveUserInfoPhoneNum:(NSString *)phoneNum andAccessToken:(NSString *)accessToken;

/*
 获取用户手机号
 return NSString *phoneNum
 */
-(NSString *)achieveUserInfoPhoneNum;

/*
 获取用户访问令牌
 return NSString *accessToken
 */
-(NSString *)achiveUserInfoAccessToken;

/*
   退出登录时使用 清除用户手机号 和 访问令牌等 存储
 */
-(void)loginOut;

/*
 保存 用户所在城市
 */
-(BOOL)setUserLocationCity:(NSString *)cityName;

/*
 获取用户所在城市
 */
-(NSString *)getUserLocationCity;

/*
 用户地理位置信息存储
 */
-(void)saveUserLocationWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude;

-(NSString *)getUserLocationWithLatitude;

-(NSString *)getUserLocationWithLongitude;

-(BOOL)isLocation;

/*
 储存用户是否成功开启充电的状态
 */
-(void)saveUserStartChargeStatus:(BOOL)status;

-(NSNumber *)getUserChargeStatus;

@end
