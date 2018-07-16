//
//  UIResource.h
//  Dnurse
//  马彦春
//  Created by ygc on 13-12-15.
//  Copyright (c) 2013年 Beijing Dnurse Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIResource : NSObject

+ (UIColor *)get0faae2Color;   // 蓝色

+ (UIColor *)getbb9563Color;

+ (UIColor *)getffffffColor;   // 白色

+ (UIColor *)getf3f3f3Color;   // 背景色

+ (UIColor *)get3e3e3eColor;

+ (UIColor *)get666566Color;

+ (UIColor *)geta6a2a3Color;   // 灰色

+ (UIColor *)getc2c2c2Color;

+ (UIColor *)gete5e5e5Color;

+ (UIColor *)get896a49Color;

+ (UIColor *)get4c3519Color;

+ (UIColor *)get8c8db9Color;

+ (UIColor *)getd0b391Color;

+ (UIColor *)geteeeeeeColor;

+ (UIColor *)get704500Color;

+ (UIColor *)getdbc4a4Color;

+ (NSString *)getDateString;

+ (NSMutableAttributedString *)changeLabelWithText:(NSString*)needText andLength:(NSInteger)length andFirstFont:(UIFont *)fFont andLastFont:(UIFont *)lFont andFirstColor:(UIColor *)fColor andLastColor:(UIColor *)lColor;

+ (UITextField *)getTextFielfWithFrame:(CGRect)frame placeholder:(NSString *)text leftImg:(NSString *)imgStr;

+ (UIButton *)getBackBtnWithImage:(NSString *)img;

+ (NSString *)getUid;

+ (NSString *)getToken:(NSString *)tokenString;

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

+ (NSString *)getSecretKey:(NSString *)methodKey;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
