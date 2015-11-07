//
//  NSArray+DH.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "NSArray+DH.h"

@implementation NSArray (DH)
- (id) safetyObjectAtIndex:(NSUInteger) index{
    return [self safetyObjectAtIndex: index
                             default: nil];
}

- (id) safetyObjectAtIndex:(NSUInteger) index default:(id)defaultValue {
    if (index < self.count && index >= 0) {
        return [self objectAtIndex: index];
    } else {
        return defaultValue;
    }
}
@end
