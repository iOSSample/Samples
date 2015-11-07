//
//  Utility.h
//  BeautifulGirls
//
//  Created by suning on 14-10-5.
//  Copyright (c) 2014年 BestBoys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (CGFloat)getLabelHeightWithWidth:(CGFloat)width
						   andText:(NSString *)text
					   andFontSize:(CGFloat)fontSize;

+ (CGFloat) getLabelHeightWithWidth:(CGFloat)width
                            andText:(NSString *)text
                            andFont:(UIFont*)font;

+ (CGFloat) getLabelWidthText:(NSString *)text
                      andFont:(UIFont*)font;

// 获取App自己对应的文档目录
+ (NSString *)getDocumentPath;

+ (NSString *)getFilePath:(NSString *)fileName;

+ (NSString *)escapeURL:(NSString *)url;

+ (NSDate *) dateWithFormatter:(NSString*) formatter time:(NSString*) time;

+ (NSString *) stringWithFormatter:(NSString*) formatter time:(NSDate*) date;

+ (id)userDefaultObjectForKey:(NSString *)key;

+ (void)setUserDefaultObjects:(NSDictionary *)dict;

+ (NSString *) getUUID;


#ifdef IN_DHDEMO
+ (NSString *) getIdfa;
#endif
/*删除文件*/
+ (BOOL) deleteFilesInFolder:(NSString *)paramPath;

+ (BOOL) deleteFolder:(NSString *)paramPath;

// 用户保存db的目录
// DocumentPath/DBDir/UserId/XXX.db
+ (NSString*) getDataBaseDirectory;

+ (id) getJSONWithString:(NSString*)input;

@end
