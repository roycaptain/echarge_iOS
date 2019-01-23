//
//  HistoryModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/11.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "HistoryModel.h"
#import "SiteModel.h"

@implementation HistoryModel

/*
 获取地点搜索历史记录
 */
+(NSArray *)getSrearchSiteHistoryInArchive
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cacheDirectory stringByAppendingPathComponent:SearchSiteHistory];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:NULL attributes:NULL];
    }
    
    NSArray *historys = [[NSArray alloc] initWithContentsOfFile:filePath];
    return historys;
}

/*
 清楚历史搜索
 */
+(void)clearUpSearchSiteHistory
{
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cacheDirectory stringByAppendingPathComponent:SearchSiteHistory];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:NULL];
}

/*
 @param SiteModel *model 地点模型
 @param NSInteger max 最多存储个数
 */
+(void)saveSearchSiteHistoryWithSiteModel:(SiteModel *)model withMaxCount:(NSInteger)max
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:SearchSiteHistory];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:NULL attributes:NULL];
    }
    
    NSArray *historys = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:historys];
    
    NSDictionary *dictionary;
    NSNumber *latitude = [NSNumber numberWithFloat:model.latitude];
    NSNumber *longitude = [NSNumber numberWithFloat:model.longitude];
    NSNumber *itemWidth = [NSNumber numberWithFloat:model.itemWidth];
    NSNumber *itemHeight = [NSNumber numberWithFloat:model.itemHeight];
    dictionary = @{@"title" : model.title,
                   @"detailTitle" : model.detailTitle,
                   @"latitude" : latitude,
                   @"longitude" : longitude,
                   @"itemWidth" : itemWidth,
                   @"itemHeight" : itemHeight
                   };
    
    if ([historys containsObject:dictionary]) {
        return;
    }
    
    if (historys.count < max) {
        [tempArr addObject:dictionary];
    } else {
        [tempArr replaceObjectAtIndex:0 withObject:dictionary];
    }
    
    NSArray *plistArr = [tempArr mutableCopy];
    [plistArr writeToFile:filePath atomically:YES];
}

/*
 获取城市切换历史记录
 */
+(NSArray *)getCitySwitchHistoryInarchive
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cacheDirectory stringByAppendingPathComponent:CitySwitchHistory];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:NULL attributes:NULL];
    }
    NSArray *historys = [[NSArray alloc] initWithContentsOfFile:filePath];
    return historys;
}

/*
 @param NSInteger max 最多存储个数
 */
+(void)saveCitySwitchHistoryWithCity:(NSString *)name withMaxCount:(NSInteger)max
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:CitySwitchHistory];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:NULL attributes:NULL];
    }
    
    NSArray *citys = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:citys];
    
    if ([citys containsObject:name]) {
        return;
    }
    if (citys.count < max) {
        [tempArr addObject:name];
    } else {
        [tempArr replaceObjectAtIndex:0 withObject:name];
    }
    
    NSArray *plistArr = [tempArr mutableCopy];
    [plistArr writeToFile:filePath atomically:YES];
}



@end
