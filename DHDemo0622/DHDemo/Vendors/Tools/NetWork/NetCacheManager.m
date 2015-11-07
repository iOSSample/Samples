//
//  NetCacheManager.m
//  DHDemo
//  该类 读写json到本地
//  Created by 杜豪 on 15/6/25.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "NetCacheManager.h"


@implementation NetCacheManager

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static NetCacheManager *netCache = nil;
    dispatch_once(&onceToken, ^{
        netCache = [[NetCacheManager alloc] init];
    });
    return netCache;
}
- (void)celanAllCache{
    if (_filePath) {
        [Utility deleteFolder:_filePath];
        _filePath = nil;
    }
}
#pragma mark - 读取某个path的缓存
- (id)loadCacheForPath:(NSString *)path atUserID:(NSString *)userid{
    if (!path) {
        return nil;
    }
    path = [self cleanPathStr:path];
    
    //设置路径
    NSString* fileName = [path md5Hash];
    if (_filePath == nil) {
        NSString *str = [self getUserCachePath:userid];
        _filePath = [Utility getFilePath: str];
        
    }
    NSString *filePath = [Utility getFilePath: [NSString stringWithFormat: @"%@%@.cache",[self getUserCachePath:userid],fileName]];
    NSLog(@"预读取本地数据 %@",filePath);

    
    //NSDictionary
    id cachedJSON = [NSDictionary dictionaryWithContentsOfFile: filePath];
    if (cachedJSON && [cachedJSON isKindOfClass:[NSDictionary class]]) {
        return cachedJSON;
    }
    
    //NSArray
    if (!cachedJSON) {
        cachedJSON = [NSArray arrayWithContentsOfFile: filePath];
        if (cachedJSON && [cachedJSON isKindOfClass:[NSArray class]]) {
            return cachedJSON;
        }
    }
    return nil;
}

#pragma mark -  将返回数据写入文件缓存
- (void)writeCacheToPath:(NSString *)path atUserID:(NSString *)userid jsonInfo:(id)JSON{
    if (!path) {
        return;
    }
    path = [self cleanPathStr:path];
    
    if (_filePath == nil) {
        NSString *str = [self getUserCachePath:userid];
        _filePath = [Utility getFilePath: str];
        
    }
    
    // 首先替换NSNull
    NSString* fileName = [path md5Hash];
    NSString *str = [NSString stringWithFormat: @"%@%@.cache",[self getUserCachePath:userid], fileName];
    NSString *filePath = [Utility getFilePath: str];
    //删除原文件
    [Utility deleteFolder:str];

    id writeToFileData = [self getFilteredData: JSON];
    
    if ([writeToFileData isKindOfClass: [NSDictionary class]] && [filePath isNonEmpty]) {
        NSDictionary* dict = writeToFileData;
        [dict writeToFile: filePath
               atomically: YES];
    }else if ([writeToFileData isKindOfClass: [NSArray class]] && [filePath isNonEmpty]) {
        NSArray* array = writeToFileData;
        [array writeToFile: filePath
                atomically: YES];
    }
    NSLog(@"写入完成%@",filePath);

}
- (id) getFilteredData:(id)JSON {
    if([JSON isKindOfClass: [NSArray class]]) {
        
        return [self filterNSNullInJSON: JSON];
    } else if ([JSON isKindOfClass: [NSDictionary class]]) {
        
        NSMutableDictionary* mutableDict = [NSMutableDictionary dictionaryWithDictionary: JSON];
        return [self filterNSNullInJSON: mutableDict];
    }
    return nil;
}
// 递归遍历 JSON 把 NSNull 过滤掉,因为有NSNull的话无法保存到文件
- (id) filterNSNullInJSON:(id)json {
    if ([json isKindOfClass: [NSArray class]]) {
        
        NSMutableArray* array = [NSMutableArray array];
        for (id subJSON in json) {
            if ([subJSON isKindOfClass: [NSDictionary class]]) {
                
                NSMutableDictionary* mutableDict = [NSMutableDictionary dictionaryWithDictionary: subJSON];
                [array addObject: [self filterNSNullInJSON: mutableDict]];
                
            } else if([subJSON isKindOfClass: [NSArray class]]) {
                
                NSMutableArray* mutableArray = [NSMutableArray arrayWithArray: subJSON];
                [array addObject: [self filterNSNullInJSON: mutableArray]];
            } else {
                
                // 什么也不做
            }
        }
        return array;
        
    } else if([json isKindOfClass: [NSDictionary class]]){
        
        NSMutableDictionary* dict = json;
        for (NSString* key in [dict allKeys]) {
            if ([dict[key] isKindOfClass: [NSNull class]]) {
                
                dict[key] = @"";
            } else if ([dict[key] isKindOfClass: [NSDictionary class]]) {
                
                NSMutableDictionary* subDict = [NSMutableDictionary dictionaryWithDictionary: dict[key]];
                dict[key] = [self filterNSNullInJSON: subDict];
                
            } else if ([dict[key] isKindOfClass: [NSArray class]]) {
                
                dict[key] = [self filterNSNullInJSON: dict[key]];
            }
        }
        return dict;
    }
    
    NSAssert(NO,@"");
    return [NSNull null];
}


- (NSString *)getUserCachePath:(NSString *)userID{
    //检测一下一级目录是否存在
    NSString *str1 = [Utility getFilePath: @"cachedJsonFile/"];
    BOOL isDir = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath: str1
                                              isDirectory: &(isDir)]) {
        NSError *error;
        BOOL bbb = [[NSFileManager defaultManager] createDirectoryAtPath: str1
                                             withIntermediateDirectories: NO
                                                              attributes: nil
                                                                   error: &error];
        
        NSLog(@"文件1不存在 新建 %d",bbb);
    }
    NSString *str2 = [Utility getFilePath: [NSString stringWithFormat:@"cachedJsonFile/%@/",userID]];
    if (![[NSFileManager defaultManager] fileExistsAtPath: str2
                                              isDirectory: &(isDir)]) {
        NSError *error;
        BOOL bbb = [[NSFileManager defaultManager] createDirectoryAtPath: str2
                                             withIntermediateDirectories: NO
                                                              attributes: nil
                                                                   error: &error];
        
        NSLog(@"文件2不存在 新建 %d",bbb);
    }
    
    return [NSString stringWithFormat:@"cachedJsonFile/%@/",userID];
}
- (NSString *)cleanPathStr:(NSString *)path{
    NSString *newPath = [path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    newPath = [newPath stringByReplacingOccurrencesOfString:@"." withString:@""];
    return newPath;
}
@end
