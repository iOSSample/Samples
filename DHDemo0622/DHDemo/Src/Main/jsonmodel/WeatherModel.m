//
//  WeatherModel.m
//  DHDemo
//
//  Created by 杜豪 on 15/6/23.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "WeatherModel.h"

@implementation retData

@end

@implementation WeatherModel

//- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error{
//    
//    self = [super initWithDictionary:dictionaryValue error:error];
//    
//    for (NSString *key in dictionaryValue) {
//// 1. 将value标记为__autoreleasing，这是因为在MTLValidateAndSetValue函数中，
////    可以会返回一个新的对象存在在该变量中
//        __autoreleasing id value = [dictionaryValue objectForKey:key];
//// 2. value如果为NSNull.null，会在使用前将其转换为nil
//        if ([value isEqual:NSNull.null]) value = nil;
//// 3. MTLValidateAndSetValue函数利用KVC机制来验证value的值对于key是否有效，
////    如果无效，则使用使用默认值来设置key的值。
////    这里同样使用了对象的KVC特性来将value值赋值给model对应于key的属性。
////    有关MTLValidateAndSetValue的实现可参考源码，在此不做详细说明。
//        BOOL success = MTLValidateAndSetValue(self, key, value, YES, error);
//        if (!success) return nil;
//    }
//    return self;
//}
@end
