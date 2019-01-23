//
//  FileManager.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/4.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (FileManager *)shareInstance
{
    static FileManager *singleton = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [NSFileManager defaultManager];
    }
    return self;
}

// 获取 Caches 目录路径
-(NSString *)getCachesPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths lastObject];
    return cacheDir;
}

// 计算缓存
-(float)getCachesSize
{
    long long size = 0;
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSDirectoryEnumerator *fileEnumerator = [self.manager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [self.manager attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size / 1024.0 / 1024.0;
}

// 清理缓存
- (void)clearCachesSize
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSDirectoryEnumerator *fileEnumerator = [self.manager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        [self.manager removeItemAtPath:filePath error:nil];
    }
}

@end
