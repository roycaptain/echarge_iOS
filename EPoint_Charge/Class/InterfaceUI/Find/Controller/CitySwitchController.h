//
//  CitySwitchController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/1.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 城市切换
 */
#import "MainViewController.h"

extern CGFloat const CitySearchViewHeight; // 搜索框的高度

@protocol CityLocationDelegate<NSObject>

-(void)cityLocationWithCity:(NSString *)city withLatitude:(CGFloat)latitude withLongitude:(CGFloat)longitude;

@end

@interface CitySwitchController : MainViewController

@property(nonatomic,weak)id<CityLocationDelegate> delegate;

@end
