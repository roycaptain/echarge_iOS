//
//  GeneralSize.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/15.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "GeneralSize.h"

@implementation GeneralSize

// 获取屏幕的宽度
+ (CGFloat)getMainScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

// 获取屏幕的高度
+ (CGFloat)getMainScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

// 获取 statusBar 的高度
+(CGFloat)getStatusBarHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

/*
 根据字符串获取宽度
 @param NSString *string
 @param NSInteger fontSize
 @param CGFloat height
 */
+(CGFloat)calculateStringWidth:(NSString *)string withFontSize:(CGFloat)fontSize withStringHeight:(CGFloat)height
{
    NSDictionary *dictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string
                   boundingRectWithSize:CGSizeMake(0, height)
                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   attributes:dictionary context:nil];
    return rect.size.width;
}

/*
 根据字符串获取高度
 @param NSString *string
 @param NSInteger fontSize
 @param CGFloat width
 */
+(CGFloat)calculateStringHeight:(NSString *)string withFontSize:(CGFloat)fontSize withStringWidth:(CGFloat)width
{
    NSDictionary *dictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string
                   boundingRectWithSize:CGSizeMake(width, 0)/*计算高度要先指定宽度*/
                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   attributes:dictionary context:nil];
    return rect.size.height;
}

@end
