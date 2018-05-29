//
//  UIColor+Hex.h
//  NetTest
//
//  Created by ygc on 13-11-23.
//  Copyright (c) 2013年 ygc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexRGB:(NSInteger)hexRGB;
+ (UIColor *)colorWithHexRGB:(NSInteger)hexRGB Alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexARGB:(NSInteger)hexARGB;
+ (UIColor *)colorWithHEX:(NSString *)HEXColorStr alpha:(CGFloat)alphaValue;

@end
