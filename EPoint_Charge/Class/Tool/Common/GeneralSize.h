//
//  GeneralSize.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/15.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NavigationBarHeight self.navigationController.navigationBar.frame.size.height // navigationBar 的高度
#define TabBarHeight self.tabBarController.tabBar.frame.size.height // tabBar 的高度

/*
 此类用于获取各种屏幕尺寸的类
 */
@interface GeneralSize : NSObject

// 获取屏幕的宽度
+(CGFloat)getMainScreenWidth;

// 获取屏幕的高度
+(CGFloat)getMainScreenHeight;

// 获取 statusBar 的高度
+(CGFloat)getStatusBarHeight;

/*
 根据字符串获取宽度
 @param NSString *string
 @param CGFloat fontSize
 @param CGFloat height
 */
+(CGFloat)calculateStringWidth:(NSString *)string withFontSize:(CGFloat)fontSize withStringHeight:(CGFloat)height;

/*
 根据字符串获取高度
 @param NSString *string
 @param CGFloat fontSize
 @param CGFloat width
 */
+(CGFloat)calculateStringHeight:(NSString *)string withFontSize:(CGFloat)fontSize withStringWidth:(CGFloat)width;



@end
