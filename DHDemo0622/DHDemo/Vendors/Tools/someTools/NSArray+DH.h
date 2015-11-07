//
//  NSArray+DH.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DH)
- (id) safetyObjectAtIndex:(NSUInteger) index;

- (id) safetyObjectAtIndex:(NSUInteger) index default:(id)defaultValue;
@end
