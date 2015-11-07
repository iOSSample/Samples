//
//  TestModel.m
//  DHDemo
//
//  Created by 杜豪 on 15/6/28.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"abc":@"WD",
             @"def":@"WS",
             @"htmp":@"h_tmp",
             @"ltmp":@"l_tmp",
             @"weather":NSNull.null
             };
}
//+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key{
//    
//    return nil;
//}
+ (NSValueTransformer *)htmpJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return @([value integerValue]);
    }];
}
+ (NSValueTransformer *)ltmpJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return @([value integerValue]);
    }];
}
- (void)setNilValueForKey:(NSString *)key{
    [self setValue:@0 forKey:key];  // For NSInteger/CGFloat/BOOL
}
@end
