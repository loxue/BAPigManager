//
//  BAAddSeedPigBean.h
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAAddSeedPigBean : NSObject

// 猪场编号
@property (nonatomic, copy) NSString *F_MerchantCode;
// 猪的类型:公猪或母猪...
@property (nonatomic, copy) NSString *F_PigType;
// 猪的品种
@property (nonatomic, copy) NSString *F_PigVariety;
// 耳标
@property (nonatomic, copy) NSString *F_EarTag;
//类别索引
//public transient int index_Category;
// 猪的类别:母猪（后备，基础），公猪（后备）母猪生仔后，就从后备变成基础了
@property (nonatomic, copy) NSString *F_PigCategory;
// 公猪：采精次数
@property (nonatomic, strong) NSNumber *F_SemanCount;
// 母猪：后备 交配，孕检，分娩，断奶
@property (nonatomic, strong) NSNumber *F_PigCurrentState;
@property (nonatomic, copy) NSString *F_PigCurrentStateName;
// 生育次数
@property (nonatomic, strong) NSNumber *F_ChildCount;
// 母猪：配种次数
@property (nonatomic, strong) NSNumber *F_MatingCount;
// 栋舍名称
@property (nonatomic, copy) NSString *F_PigHouseName;
// 栏位
@property (nonatomic, copy) NSString *F_Field;
// 出生日期
@property (nonatomic, copy) NSString *F_PigBirthday;
//记录的当前时间
//public transient long curTime;
// 猪的来源
@property (nonatomic, copy) NSString *F_PigOrigin;

@end
