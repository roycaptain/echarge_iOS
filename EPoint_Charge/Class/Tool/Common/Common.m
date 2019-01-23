//
//  Common.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/30.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "Common.h"

@implementation Common

/*
 验证手机号
 正确的手机号 YES 否则 NO
 */
+ (BOOL)checkPhoneNumInput:(NSString *)phoneNum
{
    NSString *photoRange = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";//正则表达式
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",photoRange];
    BOOL result = [regexMobile evaluateWithObject:phoneNum];
    return result ? YES : NO;
}

// 验证密码
+(BOOL)checkPasswordInput:(NSString *)password
{
    return [self isBlankString:password];
}

// 验证验证码
+(BOOL)checkIdentifyCodeInput:(NSString *)identifyCode
{
    return [self isBlankString:identifyCode];
}

/*
 判断字符串是否为空
 空字符串 return YES 否则 return NO
 */
+(BOOL)isBlankString:(NSString *)text
{
    if (!text) {
        return YES;
    }
    if ([text isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [text stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

/*
 比较版本号
 返回 YES 需要更新 否则不需要更新
 */
+(BOOL)compareNewVersion:(NSString *)version
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"]; // 获取当前版本号
    
    NSArray *serverVersionArray = [version componentsSeparatedByString:@"."];
    NSArray *currentVersionArray = [currentVersion componentsSeparatedByString:@"."];
    NSInteger minLength = MIN(serverVersionArray.count, currentVersionArray.count); // 获取字段最少的版本个数
    
    BOOL isUpdate = NO;
    for (NSInteger i = 0; i < minLength; i++) {
        NSString *serverElement = serverVersionArray[i];
        NSString *currentElement = currentVersionArray[i];
        
        NSInteger serverValue = [serverElement integerValue];
        NSInteger currentValue = [currentElement integerValue];
        
        if (currentValue < serverValue) {
            isUpdate = YES;
            break;
        }
    }
    return isUpdate;
}

/*
 交流直流电不同颜色字体
 */
+(NSAttributedString *)setFreeNumberWithText:(NSString *)freeNum andSunmNumberWithText:(NSString *)sumNum
{
    NSMutableAttributedString *freeAttri = [[NSMutableAttributedString alloc] initWithString:freeNum];
    [freeAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#02B1CD"]} range:NSMakeRange(0, freeAttri.length)];
    NSMutableAttributedString *sumAttri = [[NSMutableAttributedString alloc] initWithString:sumNum];
    [sumAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#02B1CD"]} range:NSMakeRange(0, sumAttri.length)];
    
    NSMutableAttributedString *freeTitleAttri = [[NSMutableAttributedString alloc] initWithString:@"空闲: "];
    [freeTitleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]} range:NSMakeRange(0, freeTitleAttri.length)];
    NSMutableAttributedString *sumTitlekAttri = [[NSMutableAttributedString alloc] initWithString:@"总数: "];
    [sumTitlekAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]} range:NSMakeRange(0, sumTitlekAttri.length)];
    NSMutableAttributedString *markAttri = [[NSMutableAttributedString alloc] initWithString:@" / "];
    [markAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]} range:NSMakeRange(0, markAttri.length)];
    
    [freeTitleAttri appendAttributedString:freeAttri];
    [freeTitleAttri appendAttributedString:markAttri];
    [freeTitleAttri appendAttributedString:sumTitlekAttri];
    [freeTitleAttri appendAttributedString:sumAttri];
    
    NSAttributedString *result = freeTitleAttri;
    return result;
}

@end
