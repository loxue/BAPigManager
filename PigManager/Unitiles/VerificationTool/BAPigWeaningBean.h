//
//  BAPigWeaningBean.h
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAPigWeaningBean : NSObject

// 唯一标号
@property (nonatomic, copy) NSString *F_Id;
// 猪场编号
@property (nonatomic, copy) NSString *F_MerchantCode;
// 猪编号
@property (nonatomic, copy) NSString *F_PigRecordId;
// 断奶日期
@property (nonatomic, copy) NSString *F_WeaningTime;
// 合格仔
@property (nonatomic, assign) NSInteger F_StandardPigCount;
// 次品仔
@property (nonatomic, assign) NSInteger F_BadPigCount;
// 总仔数
@property (nonatomic, assign) NSInteger F_TotalPigCount;
// 胎龄
@property (nonatomic, assign) NSInteger F_ChildCount;
// 窝总重
@property (nonatomic, assign) float F_WeightTotal;
// 窝均重
@property (nonatomic, assign) float F_WeightAverage;
// 断奶栋舍
@property (nonatomic, copy) NSString *F_PigHouseName;
// 断奶栏位
@property (nonatomic, copy) NSString *F_Field;
// 断奶管理员
@property (nonatomic, copy) NSString *F_OperatePerson;

- (BOOL)Valid;

@end
