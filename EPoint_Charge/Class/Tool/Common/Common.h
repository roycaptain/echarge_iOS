//
//  Common.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/30.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 公共方法
 */
@interface Common : NSObject

// 手机号码验证
+(BOOL)checkPhoneNumInput:(NSString *)phoneNum;

// 验证密码
+(BOOL)checkPasswordInput:(NSString *)password;

// 验证验证码
+(BOOL)checkIdentifyCodeInput:(NSString *)identifyCode;

// 判断字符串是否为空
+(BOOL)isBlankString:(NSString *)text;

/*
 比较版本号
 返回 YES 需要更新 否则不需要更新
 */
+(BOOL)compareNewVersion:(NSString *)version;

/*
 交流直流电不同颜色字体
 */
+(NSAttributedString *)setFreeNumberWithText:(NSString *)freeNum andSunmNumberWithText:(NSString *)sumNum;

@end
