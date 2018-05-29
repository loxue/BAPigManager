//
//  NSString+DNUStringExt.m
//  Dnurse
//
//  Created by Wei Li on 14-8-6.
//  Copyright (c) 2014年 Beijing Dnurse Technology Ltd. All rights reserved.
//

#import "NSString+DNUStringExt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (DNUStringExt)

//利用正则表达式验证邮箱
+ (BOOL)isValidateEmail:(NSString *)email {
    if (!email || [email isKindOfClass:[NSNull class]] || email.length < 1) {
        return NO;
    }
    NSString *emailRegex = @"^[a-zA-Z0-9][a-zA-Z0-9_\\.]+@[a-zA-Z0-9_]+\\.[a-zA-Z0-9_\\.]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码正则表达式验证
+ (BOOL)isValidatePhone:(NSString *)phone {
    if (!phone || [phone isKindOfClass:[NSNull class]] || [phone length] == 0) {
        return NO;
    }

    NSString *phoneRegex = @"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|4|5|6|7|8|9]|170)\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

//unicode编码转汉字
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           mutabilityOption:NSPropertyListImmutable
                           format:NULL
                           errorDescription:NULL];

    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

+ (NSString *)utf8ToUnicode:(NSString *)string {
    NSUInteger length = [string length];

    NSMutableString *s = [NSMutableString stringWithCapacity:0];

    for (int i = 0; i < length; i++) {
        unichar _char = [string characterAtIndex:i];

        //判断是否为英文和数字

        if (_char <= '9' && _char >= '0') {
            [s appendFormat:@"%@", [string substringWithRange:NSMakeRange(i, 1)]];
        }
        else if (_char >= 'a' && _char <= 'z') {
            [s appendFormat:@"%@", [string substringWithRange:NSMakeRange(i, 1)]];
        }
        else if (_char >= 'A' && _char <= 'Z') {
            [s appendFormat:@"%@", [string substringWithRange:NSMakeRange(i, 1)]];
        }
        else {
            [s appendFormat:@"\\u%x", [string characterAtIndex:i]];
        }
    }

    return s;
}

- (NSString *)stringFromMD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

- (BOOL)isIncludeSpecialCharact {
    NSRange urgentRange = [self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"-/:;()$&@\".,?!'[]{}#%^*+=_\\|~<>€£¥•.,?!'，。？！…～：“—^_^《【、；「」‘’】》"]];

    if (urgentRange.location == NSNotFound) {
        return NO;
    }

    return YES;
}

-(BOOL)isAllCharacterString {
    NSString *regex = @"-/:;()$&@\".,?!'[]{}#%^*+=_\\|~<>€£¥•.,?!'，。？！…～：“—^_^《【、；「」‘’】》";//规定的特殊字符，可以自己随意添加

    //计算字符串长度
    NSInteger str_length = [self length];

    NSInteger allIndex = 0;
    for (int i = 0; i<str_length; i++) {
        //取出i
        NSString *subStr = [self substringWithRange:NSMakeRange(i, 1)];
        if([regex rangeOfString:subStr].location != NSNotFound) {  //存在
            allIndex++;
        }
    }

    if (str_length == allIndex) {
        //纯特殊字符
        return YES;
    }
    return NO;
}

- (BOOL)isAllNumber {
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];

    //符合數字條件的有幾個字元
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self
                                 options:NSMatchingReportProgress
                                 range:NSMakeRange(0, self.length)];

    if (self.length == tNumMatchCount) {
        return YES;
    }

    return NO;
}

- (BOOL)isAllLetters {
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger tNumMatchCount = [tLetterRegularExpression numberOfMatchesInString:self
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, self.length)];
    if (self.length == tNumMatchCount) {
        return YES;
    }
    return NO;
}

- (BOOL)stringContainsEmoji {
    __block BOOL returnValue = NO;

    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
     options:NSStringEnumerationByComposedCharacterSequences
     usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        }
        else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        }
        else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            }
            else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            }
            else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            }
            else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            }
            else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];

    return returnValue;
}

- (BOOL)getBoolWithString {
    NSString *set = [NSString stringWithFormat:@"%@", self];
    if ([set isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)changeAsset {
    NSString *amountStr = [NSString stringWithFormat:@"%@", self];
    if (amountStr && ![amountStr isEqualToString:@""]) {
        NSInteger num = [amountStr floatValue];
        if (num < 10000) {
            return amountStr;
        } else {
            NSString *str = [NSString stringWithFormat:@"%.2f", num/10000.00];
            return [NSString stringWithFormat:@"%@万",str];
        }
    } else {
        return @"0";
    }
}

@end
