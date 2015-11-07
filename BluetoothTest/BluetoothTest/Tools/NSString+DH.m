//
//  NSString+DH.m
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "NSString+DH.h"
@implementation NSNull (SpeakOut)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) isNonEmpty {
    return NO;
}

- (BOOL)isEqualToString:(NSString*)string {
    return NO;
}

@end

@implementation NSString (DH)

- (NSString *)URLEncodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}

- (NSString*)URLDecodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}

static NSMutableCharacterSet* emptyStringSet = nil;
- (BOOL) isNonEmpty {
    if (emptyStringSet == nil) {
        emptyStringSet = [[NSMutableCharacterSet alloc] init];
        [emptyStringSet formUnionWithCharacterSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [emptyStringSet formUnionWithCharacterSet: [NSCharacterSet characterSetWithCharactersInString: @"　"]];
    }
    
    if ([self length] == 0) {
        return NO;
    }
    if ([self isEqualToString:@"(null)"]) {
        return NO;
    }
    NSString* str = [self stringByTrimmingCharactersInSet:emptyStringSet];
    return [str length] > 0;
}

- (NSString*) trimSpace {
    
    if (emptyStringSet == nil) {
        emptyStringSet = [[NSMutableCharacterSet alloc] init];
        [emptyStringSet formUnionWithCharacterSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [emptyStringSet formUnionWithCharacterSet: [NSCharacterSet characterSetWithCharactersInString: @"　"]];
    }
    
    return [self stringByTrimmingCharactersInSet: emptyStringSet];
}

- (NSString*) trimCharacters {
    NSCharacterSet *charactersSet = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    return [self stringByTrimmingCharactersInSet: charactersSet];
}

- (NSString*) trimEnglishLetters {
    NSCharacterSet *charactersSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"];
    return [self stringByTrimmingCharactersInSet: charactersSet];
}

//
// 将当前字符串解析成为JSON对象(至少容器，即最外层对象为Mutable。最外层对象可能是NSMutableDictionary, 或NSMutableArray)
//
- (id) mutableObjectFromJSONString {
    return [NSJSONSerialization JSONObjectWithData: [self dataUsingEncoding: NSUTF8StringEncoding]
                                           options: NSJSONReadingMutableContainers
                                             error: nil];
}
- (id) objectFromJSONString {
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData: [self dataUsingEncoding: NSUTF8StringEncoding]
                                           options: 0
                                             error: &error];
}

+ (NSString*) formatDistance:(CGFloat) distance {
    if (distance < 1000) {
        NSInteger range = (NSInteger)(distance / 100 + 0.5) * 100;
        if (range == 0) {
            range = 100;
        }
        return [NSString stringWithFormat:@"%ld米内", range];
        
    } else {
        return [NSString stringWithFormat:@"%.1f千米", distance / 1000.0];
    }
}

+ (NSString*) formatPhoneNum: (NSString*) phoneNum {
    NSString* model = [UIDevice currentDevice].model;
    if ([model rangeOfString:@"iPhone"].length > 0) {
        return [NSString stringWithFormat:@"<a href=\"tel:%@\">%@</a>", phoneNum, phoneNum];
        
    } else {
        return phoneNum;
    }
}

+ (NSString*) formatEmail: (NSString*) email {
    return [NSString stringWithFormat:@"<a href=\"mailto:%@\">%@</a>", email, email];
}

- (BOOL) isVailidEmailAddress {
    
    NSString *emailRegex = @"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject: self];
    
}

- (NSString *) stringByEscape: (BOOL) escape
                  escapeMinus: (BOOL) escapeMinus
          isTTStyledTextLabel: (BOOL) isTTStyledTextLabel
{
    NSString * str = self;
    
    if (isTTStyledTextLabel) {
        
        if (escape) {
            str = [str stringByReplacingOccurrencesOfString: @"&lt;" withString: @"<"];
            str = [str stringByReplacingOccurrencesOfString: @"&amp;" withString: @"&"];
        } else {
            str = [str stringByReplacingOccurrencesOfString: @"&" withString: @"&amp;"];
            if (escapeMinus) {
                str = [str stringByReplacingOccurrencesOfString: @"<" withString: @"&lt;"];
            }
        }
    }
    
    if (escape) {
        str = [str stringByReplacingOccurrencesOfString: @"\\" withString: @"\\\\"];
        str = [str stringByReplacingOccurrencesOfString: @"\r" withString: @"."];
        str = [str stringByReplacingOccurrencesOfString: @"\n" withString: @"."];
        str = [str stringByReplacingOccurrencesOfString: @"\f" withString: @" "];
        str = [str stringByReplacingOccurrencesOfString: @"\t" withString: @" "];
        str = [str stringByReplacingOccurrencesOfString: @"\"" withString: @"\\\""];
        str = [str stringByReplacingOccurrencesOfString: @"\x08" withString: @" "];
        
        // Construct HashMap
        NSDictionary * urlSpecialChars = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"%22", @"\"",
                                          @"%3C", @"<",
                                          @"%3E", @">",
                                          @"%5C", @"\\",
                                          @"%5E", @"^",
                                          @"%5B", @"[",
                                          @"%5D", @"]",
                                          @"%60", @"`",
                                          @"%2B", @"+",
                                          @"%24", @"$",
                                          @"%2C", @",",
                                          @"%40", @"@",
                                          @"%3A", @":",
                                          @"%3B", @";",
                                          @"%2F", @"/",
                                          @"%21", @"!",
                                          @"%23", @"#",
                                          @"%3F", @"?",
                                          @"%3D", @"=",
                                          @"%26", @"&",
                                          nil
                                          ];
        
        
        for (NSString * key in urlSpecialChars) {
            str = [str stringByReplacingOccurrencesOfString: key withString: [urlSpecialChars objectForKey: key]];
        }
    } else {
        for (int i = 0; i < 32; ++i) {
            str = [str stringByReplacingOccurrencesOfString: [NSString stringWithFormat: @"%c", i]
                                                 withString: @" "];
        }
        str = [str stringByReplacingOccurrencesOfString: [NSString stringWithFormat: @"%c", 127]
                                             withString: @" "];
    }
    return str;
}

- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

/**
 * Parses a URL query string into a dictionary where the values are arrays.
 *
 * A query string is one that looks like &param1=value1&param2=value2...
 *
 * The resulting NSDictionary will contain keys for each parameter name present in the query.
 * The value for each key will be an NSArray which may be empty if the key is simply present
 * in the query. Otherwise each object in the array with be an NSString corresponding to a value
 * in the query for that parameter.
 */
- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 1 || kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSMutableArray* values = [pairs objectForKey:key];
            if (nil == values) {
                values = [NSMutableArray array];
                [pairs setObject:values forKey:key];
            }
            if (kvPair.count == 1) {
                [values addObject:[NSNull null]];
                
            } else if (kvPair.count == 2) {
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByReplacingPercentEscapesUsingEncoding:encoding];
                [values addObject:value];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Returns a string that has been escaped for use as a URL parameter.
 */
- (NSString *)stringByAddingPercentEscapesForURLParameter {
    
    CFStringRef buffer =
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (__bridge CFStringRef)self,
                                            NULL,
                                            (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8);
    
    NSString *result = [NSString stringWithString:(__bridge NSString *)buffer];
    
    CFRelease(buffer);
    
    return result;
}


/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator]) {
        NSString* value = [GET_STRING([query objectForKey:key]) stringByAddingPercentEscapesForURLParameter];
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    if ([self rangeOfString:@"?"].location == NSNotFound) {
        return [self stringByAppendingFormat:@"?%@", params];
        
    } else {
        return [self stringByAppendingFormat:@"&%@", params];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)md5Hash {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)sha1Hash {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1Hash];
}



@end
