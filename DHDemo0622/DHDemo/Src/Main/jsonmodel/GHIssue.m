//
//  GHIssue.m
//  DHDemo
//
//  Created by 杜豪 on 15/6/23.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "GHIssue.h"

@implementation GHIssue
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"URL": @"url",
             @"HTMLURL": @"html_url",
             @"number": @"number",
             @"state": @"state",
             @"reporterLogin": @"user.login",
             @"assignee": @"assignee",
             @"updatedAt": @"updated_at"
             };
}

+ (NSValueTransformer *)URLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)stateJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"open": @(GHIssueStateOpen),
                                                                           @"closed": @(GHIssueStateClosed)
                                                                           }];
}

//+ (NSValueTransformer *)assigneeJSONTransformer {
//    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:GHUser.class];
//}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    // Store a value that needs to be determined locally upon initialization.
    _retrievedAt = [NSDate date];
    
    return self;
}

@end
