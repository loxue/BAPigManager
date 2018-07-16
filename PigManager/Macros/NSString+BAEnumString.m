//
//  NSString+BAEnumString.m
//  PigManager
//
//  Created by imac on 2018/7/4.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "NSString+BAEnumString.h"

@implementation NSString (BAEnumString)

+ (NSString *)stringWithPigHouseType:(BAPigHouseType)pigType {
    NSString *pigHouseTypeString;
    switch (pigType) {
        case 1:
        {
            pigHouseTypeString = @"后备栋";
        }
            break;
        case 2:
        {
            pigHouseTypeString = @"配怀栋";
        }
            break;
        case 3:
        {
            pigHouseTypeString = @"分娩栋";
        }
            break;
        case 4:
        {
            pigHouseTypeString = @"公猪栋";
        }
            break;
        case 5:
        {
            pigHouseTypeString = @"种猪栋";
        }
            break;
        case 6:
        {
            pigHouseTypeString = @"保育栋";
        }
            break;
        case 7:
        {
            pigHouseTypeString = @"育肥栋";
        }
            break;
        case 8:
        {
            pigHouseTypeString = @"育成栋";
        }
            break;
            
        default:
            break;
    }
    return pigHouseTypeString;
}

+ (NSString *)stringWithPigKindType:(BAPigKindType)pigType {
    NSString *pigKindTypeString;
    switch (pigType) {
        case 1:
        {
            pigKindTypeString = @"后备栋";
        }
            break;
        case 2:
        {
            pigKindTypeString = @"配怀栋";
        }
            break;
        case 3:
        {
            pigKindTypeString = @"分娩栋";
        }
            break;
        case 4:
        {
            pigKindTypeString = @"公猪栋";
        }
            break;
            
        default:
            break;
    }
    return pigKindTypeString;
}

+ (NSString *)stringWithPigType:(BAPigPregnancyTestType)pigType {
    NSString *pigPregnancyTestTypeString;
    switch (pigType) {
        case 1:
        {
            pigPregnancyTestTypeString = @"返情空怀";
        }
            break;
        case 2:
        {
            pigPregnancyTestTypeString = @"B超鉴定空怀";
        }
            break;
        case 3:
        {
            pigPregnancyTestTypeString = @"流产空怀";
        }
            break;
            
        default:
            break;
    }
    return pigPregnancyTestTypeString;
}

+ (NSString *)stringWithPighouseType:(NSString *)pigHouseType {
    NSString *pigHouseString;
    if ([pigHouseType isEqualToString:@"后备栋"]) {
        pigHouseString = @"1";
    } else if ([pigHouseType isEqualToString:@"配怀栋"]) {
        pigHouseString = @"2";
    } else if ([pigHouseType isEqualToString:@"分娩栋"]) {
        pigHouseString = @"3";
    } else if ([pigHouseType isEqualToString:@"公猪栋"]) {
        pigHouseString = @"4";
    } else if ([pigHouseType isEqualToString:@"种猪栋"]) {
        pigHouseString = @"5";
    } else if ([pigHouseType isEqualToString:@"保育栋"]) {
        pigHouseString = @"6";
    } else if ([pigHouseType isEqualToString:@"育肥栋"]) {
        pigHouseString = @"7";
    } else if ([pigHouseType isEqualToString:@"育成栋"]) {
        pigHouseString = @"8";
    } else if ([pigHouseType isEqualToString:@"1"]) {
        pigHouseString = @"后备栋";
    } else if ([pigHouseType isEqualToString:@"2"]) {
        pigHouseString = @"配怀栋";
    } else if ([pigHouseType isEqualToString:@"3"]) {
        pigHouseString = @"分娩栋";
    } else if ([pigHouseType isEqualToString:@"4"]) {
        pigHouseString = @"公猪栋";
    } else if ([pigHouseType isEqualToString:@"5"]) {
        pigHouseString = @"种猪栋";
    } else if ([pigHouseType isEqualToString:@"6"]) {
        pigHouseString = @"保育栋";
    } else if ([pigHouseType isEqualToString:@"7"]) {
        pigHouseString = @"育肥栋";
    } else if ([pigHouseType isEqualToString:@"8"]) {
        pigHouseString = @"育成栋";
    }
    return pigHouseString;
}

@end
