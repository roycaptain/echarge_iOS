//
//  HistoryModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/11.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 对于搜索历史的数据的进行本地存储操作
 */
#import <Foundation/Foundation.h>

@class SiteModel;

@interface HistoryModel : NSObject

/*
 获取地点搜索历史记录
 */
+(NSArray *)getSrearchSiteHistoryInArchive;

/*
 清楚历史搜索
 */
+(void)clearUpSearchSiteHistory;

/*
 @param SiteModel *model 地点模型
 @param NSInteger max 最多存储个数
 */
+(void)saveSearchSiteHistoryWithSiteModel:(SiteModel *)model withMaxCount:(NSInteger)max;

/*
 获取城市切换历史记录
 */
+(NSArray *)getCitySwitchHistoryInarchive;

/*
 存储搜索城市历史记录
 @param NSInteger max 最多存储个数
 */
+(void)saveCitySwitchHistoryWithCity:(NSString *)name withMaxCount:(NSInteger)max;

@end
