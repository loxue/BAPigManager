//
//  NSDate+BAPicker.h
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BAPicker)

+ (NSString *)currentDateString;
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr;

@end
