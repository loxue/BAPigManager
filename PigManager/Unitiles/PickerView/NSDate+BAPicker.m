//
//  NSDate+BAPicker.m
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "NSDate+BAPicker.h"

@implementation NSDate (BAPicker)

#pragma mark - 获取当前的时间
+ (NSString *)currentDateString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark - 按指定格式获取当前的时间
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterStr;
    return [formatter stringFromDate:currentDate];
}

@end
