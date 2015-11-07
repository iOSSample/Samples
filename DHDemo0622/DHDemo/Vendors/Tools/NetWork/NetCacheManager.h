//
//  NetCacheManager.h
//  DHDemo
//
//  Created by 杜豪 on 15/6/25.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetCacheManager : NSObject{
    NSString *_filePath;
}

+ (instancetype)sharedInstance;

#pragma mark - 读取某个path的缓存
- (id)loadCacheForPath:(NSString *)path atUserID:(NSString *)userid;
#pragma mark -  将返回数据写入文件缓存
- (void)writeCacheToPath:(NSString *)path atUserID:(NSString *)userid jsonInfo:(id)JSON;

- (void)celanAllCache;
@end
