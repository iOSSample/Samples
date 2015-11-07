//
//  NSNull+AvoidCrash.m
//  51talk
//
//  Created by sunny on 15-3-27.
//  Copyright (c) 2015年 51talk. All rights reserved.
//

#import "NSNull+AvoidCrash.h"
#import "JRSwizzle.h"

@implementation NSNull (AvoidCrash)

- (NSUInteger)count {
    return 0;
}

- (NSUInteger)length { return 0; }

- (NSInteger)integerValue { return 0; };

- (CGFloat)floatValue { return 0; };

- (NSString *)description { return @"0(null)"; } // so I know it was NSNull in log messages

- (NSArray *)componentsSeparatedByString:(NSString *)separator { return @[]; }

- (id)objectForKey:(id)key { return nil; }

- (BOOL)boolValue { return NO; }

- (id)objectForKeyedSubscript:(id)key {
    NSAssert(NO , @"nsnull not respond to selctore");
    return nil;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    NSAssert(NO , @"nsnull not respond to selctore");
    return nil;
}

- (id)objectAtIndex:(NSUInteger)index {
    NSAssert(NO , @"nsnull not respond to selctore");
    return nil;
}

@end
