//
//  NSString+BAEnumString.h
//  PigManager
//
//  Created by imac on 2018/7/4.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BAPigHouseTypeHoubei = 1,       // 后备栋
    BAPigHouseTypePeihuai = 2,      // 配怀栋
    BAPigHouseTypeFenmian = 3,      // 分娩栋
    BAPigHouseTypeGongzhu = 4,      // 公猪栋
    BAPigHouseTypeZhongzhu = 5,     // 种猪栋
    BAPigHouseTypeBaoyu = 6,        // 保育栋
    BAPigHouseTypeYufei = 7,        // 育肥栋
    BAPigHouseTypeYucheng = 8       // 育成栋
} BAPigHouseType;

typedef enum {
    BAPigKindTypeMuzhu = 1,        // 母猪
    BAPigKindTypeGongzhu = 2,      // 公猪
    BAPigKindTypeShangpinzhu = 3,  // 商品猪
    BAPigKindTypeZhuzai = 4        // 猪仔
} BAPigKindType;

typedef enum {
    BAPigPregnancyTestTypeFQkongbei = 1,      // 返情空怀
    BAPigPregnancyTestTypeBCkongbei = 2,      // B超鉴定空怀
    BAPigPregnancyTestTypeLCkongbei = 3       // 流产空怀
} BAPigPregnancyTestType;


@interface NSString (BAEnumString)

+ (NSString *)stringWithPigHouseType:(BAPigHouseType)pigType;
+ (NSString *)stringWithPigKindType:(BAPigKindType)pigType;
+ (NSString *)stringWithPigType:(BAPigPregnancyTestType)pigType;

// 返回F_ItemId

+ (NSString *)stringWithPighouseType:(NSString *)pigHouseType;

@end
