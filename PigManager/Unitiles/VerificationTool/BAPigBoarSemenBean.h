//
//  BAPigBoarSemenBean.h
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//  采精

#import <Foundation/Foundation.h>

@interface BAPigBoarSemenBean : NSObject

#pragma mark - property
// 唯一标号
@property (nonatomic, copy) NSString *F_Id;
// 猪场编号
@property (nonatomic, copy) NSString *F_MerchantCode;
// 猪编号
@property (nonatomic, copy) NSString *F_PigRecordId;
// 采精量
@property (nonatomic, copy) NSString *F_Quantity;
// 采精品质
@property (nonatomic, copy) NSString *F_QuantityLevel;
// 颜色
@property (nonatomic, copy) NSString *F_Color;
// 颜色品质
@property (nonatomic, copy) NSString *F_ColorLevel;
// 气味
@property (nonatomic, copy) NSString *F_Smell;
// 气味品质
@property (nonatomic, copy) NSString *F_SmellLevel;
// 活力
@property (nonatomic, copy) NSString *F_Energy;
// 活力品质
@property (nonatomic, copy) NSString *F_EnergyLevel;
// 密度
@property (nonatomic, copy) NSString *F_DenSity;
// 密度品质
@property (nonatomic, copy) NSString *F_DenSityLevel;
// 畸形率
@property (nonatomic, copy) NSString *F_Defomity;
// 畸形率品质
@property (nonatomic, copy) NSString *F_DefomityLevel;
// 精液等级
@property (nonatomic, copy) NSString *F_TotalLevel;
// 稀释标准
@property (nonatomic, copy) NSString *F_DeluteLevel;
// 稀释份数
@property (nonatomic, copy) NSString *F_DeluteCount;
// 责任人
@property (nonatomic, copy) NSString *F_OperatePerson;
// 操作日期
@property (nonatomic, copy) NSString *F_OperateTime;
// 日期
@property (nonatomic, strong) NSNumber *operateTime;

#pragma mark - method

//各种品质判断标准
- (NSString *)GetQuantityLevel;
//颜色是否合格
- (NSString *)GetColorLevel;
//气味是否合格
- (NSString *)GetSmellLevel;

- (NSString *)GetEnergyLevel;

@end
