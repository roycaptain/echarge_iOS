//
//  FileManager.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/4.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 文件操作模块
 */
#import <Foundation/Foundation.h>

@interface FileManager : NSObject

@property(nonatomic,strong)NSFileManager *manager;

+(FileManager *)shareInstance;

// 获取 Caches 目录路径
-(NSString *)getCachesPath;

// 计算缓存
-(float)getCachesSize;

// 清理缓存
- (void)clearCachesSize;

@end
