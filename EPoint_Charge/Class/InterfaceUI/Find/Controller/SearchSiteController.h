//
//  SearchSiteController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/10.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 搜索地名界面
 */
#import "MainViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

extern NSString *const SiteHistoryCellIdentifier;
extern NSString *const SiteHeaderIdentifier;

@protocol SearchSiteDelegate<NSObject>

// 传递搜索地点
-(void)locationMapCenterSiteWithLatitude:(CGFloat)latitude withLongitude:(CGFloat)longitude;

@end

@interface SearchSiteController : MainViewController

@property(nonatomic,weak)id<SearchSiteDelegate> delegate;

@end
