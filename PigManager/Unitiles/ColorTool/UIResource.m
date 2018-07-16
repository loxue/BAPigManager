//
//  UIResource.m
//  Dnurse
//  马彦春
//  Created by ygc on 13-12-15.
//  Copyright (c) 2013年 Beijing Dnurse Technology Ltd. All rights reserved.
//

#import "UIResource.h"
#import "UIColor+Hex.h"

@implementation UIResource

+ (UIColor *)get0faae2Color {
    static UIColor *Color1 = nil;
    static dispatch_once_t onceToken1;
    
    dispatch_once(&onceToken1, ^{
        Color1 = [UIColor colorWithHEX:@"#0faae2" alpha:1.0f];
    });
    return Color1;
}

+ (UIColor *)getbb9563Color {
    static UIColor *Color2 = nil;
    static dispatch_once_t onceToken2;
    
    dispatch_once(&onceToken2, ^{
        Color2 = [UIColor colorWithHEX:@"#bb9563" alpha:1.0f];
    });
    return Color2;
}

+ (UIColor *)getffffffColor {
    static UIColor *Color3 = nil;
    static dispatch_once_t onceToken3;
    
    dispatch_once(&onceToken3, ^{
        Color3 = [UIColor colorWithHEX:@"#ffffff" alpha:1.0f];
    });
    return Color3;
}

+ (UIColor *)getf3f3f3Color {
    static UIColor *Color4 = nil;
    static dispatch_once_t onceToken4;
    
    dispatch_once(&onceToken4, ^{
        Color4 = [UIColor colorWithHEX:@"#f3f3f3" alpha:1.0f];
    });
    return Color4;
}

+ (UIColor *)get3e3e3eColor {
    static UIColor *Color5 = nil;
    static dispatch_once_t onceToken5;
    
    dispatch_once(&onceToken5, ^{
        Color5 = [UIColor colorWithHEX:@"#3e3e3e" alpha:1.0f];
    });
    return Color5;
}

+ (UIColor *)get666566Color {
    static UIColor *Color6 = nil;
    static dispatch_once_t onceToken6;
    
    dispatch_once(&onceToken6, ^{
        Color6 = [UIColor colorWithHEX:@"#666566" alpha:1.0f];
    });
    return Color6;
}

+ (UIColor *)geta6a2a3Color {
    static UIColor *Color7 = nil;
    static dispatch_once_t onceToken7;
    
    dispatch_once(&onceToken7, ^{
        Color7 = [UIColor colorWithHEX:@"#a6a2a3" alpha:1.0f];
    });
    return Color7;
}

+ (UIColor *)getc2c2c2Color {
    static UIColor *Color8 = nil;
    static dispatch_once_t onceToken8;
    
    dispatch_once(&onceToken8, ^{
        Color8 = [UIColor colorWithHEX:@"#c2c2c2" alpha:1.0f];
    });
    return Color8;
}

+ (UIColor *)gete5e5e5Color {
    static UIColor *Color9 = nil;
    static dispatch_once_t onceToken9;
    
    dispatch_once(&onceToken9, ^{
        Color9 = [UIColor colorWithHEX:@"#e5e5e5" alpha:1.0f];
    });
    return Color9;
}

+ (UIColor *)get896a49Color {
    static UIColor *Color10 = nil;
    static dispatch_once_t onceToken10;
    
    dispatch_once(&onceToken10, ^{
        Color10 = [UIColor colorWithHEX:@"#896a49" alpha:1.0f];
    });
    return Color10;
}

+ (UIColor *)get4c3519Color {
    static UIColor *Color11 = nil;
    static dispatch_once_t onceToken11;
    
    dispatch_once(&onceToken11, ^{
        Color11 = [UIColor colorWithHEX:@"#4c3519" alpha:1.0f];
    });
    return Color11;
}

+ (UIColor *)get8c8db9Color {
    static UIColor *Color12 = nil;
    static dispatch_once_t onceToken12;

    dispatch_once(&onceToken12, ^{
        Color12 = [UIColor colorWithHEX:@"#8c8db9" alpha:1.0f];
    });
    return Color12;
}

+ (UIColor *)getd0b391Color {
    static UIColor *Color13 = nil;
    static dispatch_once_t onceToken13;

    dispatch_once(&onceToken13, ^{
        Color13 = [UIColor colorWithHEX:@"#d0b391" alpha:1.0f];
    });
    return Color13;
}

+ (UIColor *)geteeeeeeColor {
    static UIColor *Color14 = nil;
    static dispatch_once_t onceToken14;

    dispatch_once(&onceToken14, ^{
        Color14 = [UIColor colorWithHEX:@"#eeeeee" alpha:1.0f];
    });
    return Color14;
}

+ (UIColor *)get704500Color {
    static UIColor *Color15 = nil;
    static dispatch_once_t onceToken15;

    dispatch_once(&onceToken15, ^{
        Color15 = [UIColor colorWithHEX:@"#704500" alpha:1.0f];
    });
    return Color15;
}

+ (UIColor *)getdbc4a4Color {
    static UIColor *Color16 = nil;
    static dispatch_once_t onceToken16;

    dispatch_once(&onceToken16, ^{
        Color16 = [UIColor colorWithHEX:@"#dbc4a4" alpha:1.0f];
    });
    return Color16;
}

+ (NSString *)getDateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld%u", (long)[datenow timeIntervalSince1970], arc4random() %100000];
    return timeSp;
}

+ (UITextField *)getTextFielfWithFrame:(CGRect)frame placeholder:(NSString *)text leftImg:(NSString *)imgStr {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.keyboardType = UIKeyboardAppearanceAlert;
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    textField.textColor = [UIResource get666566Color];
    textField.font = MXFont14;
    NSMutableParagraphStyle *style = [textField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = textField.font.lineHeight - (textField.font.lineHeight - MXFont14.lineHeight) / 2.0;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{
                                                                                                   NSForegroundColorAttributeName: [UIResource geta6a2a3Color],
                                                                                                   NSFontAttributeName : MXFont14,
                                                                                                   NSParagraphStyleAttributeName :style}];

    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 32, 18)];
    left.image = [UIImage imageNamed:imgStr];
    left.contentMode = UIViewContentModeLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    if (![imgStr isEqualToString:@""]) {
        textField.leftView = left;
    }
    if ([imgStr isEqualToString:@"emptyLeft"]) {
        left.width = 10;
    }
    return textField;
}

+ (NSMutableAttributedString *)changeLabelWithText:(NSString*)needText andLength:(NSInteger)length andFirstFont:(UIFont *)fFont andLastFont:(UIFont *)lFont andFirstColor:(UIColor *)fColor andLastColor:(UIColor *)lColor {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    [attrString addAttribute:NSFontAttributeName value:fFont range:NSMakeRange(0, length)];
    [attrString addAttribute:NSFontAttributeName value:lFont range:NSMakeRange(length, attrString.length-length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:fColor range:NSMakeRange(0, length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:lColor range:NSMakeRange(length, attrString.length-length)];
    return attrString;
}

+ (UIButton *)getBackBtnWithImage:(NSString *)img {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 20, 40, 44);
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateHighlighted];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return button;
}

+ (NSString *)getUid {
    NSString *uid = [NSString stringWithFormat:@"%@", [UserDefaults objectForKey:UID]];
    if ([uid isEqualToString:@"(null)"]) {
        uid = @"";
    }
    return uid;
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (NSString *)getSecretKey:(NSString *)methodKey {
    NSString *key = [[NSString stringWithFormat:@"%@%@%@", methodKey, [self getUid], @"CAIHANGKEY"] stringFromMD5];
    return key;
}

+ (NSString *)getToken:(NSString *)tokenString {
    return [tokenString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.f, 0.f, 1.f, 1.f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
