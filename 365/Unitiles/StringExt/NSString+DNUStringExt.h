//
//  NSString+DNUStringExt.h
//  Dnurse
//
//  Created by Wei Li on 14-8-6.
//  Copyright (c) 2014年 Beijing Dnurse Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DNUStringExt)

//校验邮箱
+ (BOOL)isValidateEmail:(NSString *)email;

//校验手机号
+ (BOOL)isValidatePhone:(NSString *)phone;

//unicode编码转汉字
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

//UTF-8转Unicode
+ (NSString *)utf8ToUnicode:(NSString *)string;

//返回字符串的MD5形式
- (NSString *)stringFromMD5;

//判断字符串中是否包含特殊字符
- (BOOL)isIncludeSpecialCharact;

//判断是否为纯特殊字符
- (BOOL)isAllCharacterString;

//是否为纯数字
- (BOOL)isAllNumber;

//是否为纯字母
- (BOOL)isAllLetters;

//是否包含Emoji表情
- (BOOL)stringContainsEmoji;

- (BOOL)getBoolWithString;

- (NSString *)changeAsset;

@end
