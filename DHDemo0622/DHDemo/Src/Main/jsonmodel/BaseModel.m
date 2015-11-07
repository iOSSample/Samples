//
//  BaseModel.m
//  DHDemo
//
//  Created by 杜豪 on 15/6/23.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
/*由于API使用的开发语言与iOS所使用的Objective-C是截然不同的，
 所以可能将一些保留关键字作为property的名称(如id)， 或者不小心override掉基类的属性(如description)。
 还有可能API中使用了一个很糟糕的名称，或者使用了不符合Objective- C命名规范的名称，
 这些我们都需要作转换。
 
 只需要实现MTLJSONSerializing protocol
 并在+JSONKeyPathsByPropertyKey方法中定义好新旧名称的映射关系即可，
 Mantle会在序列化及反序列化时对属性名进行自动的转换。*/

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *keypath = @{@"identifier": @"id",
                              @"displayDiscription": @"description",
                              @"thisIsANewShit": @"newShit",
                              @"creativeProduct": @"copyToChina",
                              @"betterPropertyName": @"m_wired_propertyName",
                              @"WD":@"retData.WD",
                              @"WS":@"retData.WS",};
    return keypath;
}
//- (void)setNilValueForKey:(NSString *)key{
//    
//}
@end
