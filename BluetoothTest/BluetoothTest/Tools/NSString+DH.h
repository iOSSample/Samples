//
//  NSString+DH.h
//  DHDemo
//
//  Created by 杜豪 on 15/3/19.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//
//



//  NSString+URLEncoding.h
//
//  Created by Jon Crosby on 10/19/07.
//  Copyright 2007 Kaboomerang LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

// 代码路径:
// http://oauth.googlecode.com/svn/code/obj-c/OAuthConsumer/
// 参考:
// http://simonwoodside.com/weblog/2009/4/22/how_to_really_url_encode/
//
#import <Foundation/Foundation.h>

@interface NSNull (SpeakOut)
@end
@interface NSString (DH)

// URL编码和解码
- (NSString*) URLEncodedString;
- (NSString*) URLDecodedString;

// 空白字符的处理
- (BOOL)isNonEmpty;
- (NSString*) trimSpace;
- (NSString*) trimCharacters;
- (NSString*) trimEnglishLetters;


- (id) mutableObjectFromJSONString;
- (id) objectFromJSONString;

// JSON的处理



+ (NSString*) formatDistance:(CGFloat) distance;
+ (NSString*) formatPhoneNum: (NSString*) phoneNum;
+ (NSString*) formatEmail: (NSString*) email;



- (BOOL) isVailidEmailAddress;

- (NSString *) stringByEscape: (BOOL) escape
escapeMinus: (BOOL) escapeMinus
          isTTStyledTextLabel: (BOOL) isTTStyledTextLabel;

- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;
- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding;
- (NSString *)stringByAddingPercentEscapesForURLParameter;
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;


/**
 * Calculate the md5 hash of this string using CC_MD5.
 *
 * @return md5 hash of this string
 */
@property (nonatomic, readonly) NSString* md5Hash;

/**
 * Calculate the SHA1 hash of this string using CommonCrypto CC_SHA1.
 *
 * @return NSString with SHA1 hash of this string
 */
@property (nonatomic, readonly) NSString* sha1Hash;

@end

