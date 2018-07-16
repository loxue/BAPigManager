//
//  BAPigDeliverBean.h
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAPigDeliverBean : NSObject

// 唯一标号
@property (nonatomic, copy) NSString *F_Id;
// 猪场编号
@property (nonatomic, copy) NSString *F_MerchantCode;
// 猪编号
@property (nonatomic, copy) NSString *F_PigRecordId;
// 分娩日期
@property (nonatomic, copy) NSString *F_DeliverTime;
// 健康仔
@property (nonatomic, assign) NSInteger *F_GoodPigCount;
// 弱仔
@property (nonatomic, assign) NSInteger *F_WeakPigCount;
// 死胎
@property (nonatomic, assign) NSInteger *F_DiePigCount;
// 木乃伊仔
@property (nonatomic, assign) NSInteger *F_MummyPigCount;
// 畸形仔
@property (nonatomic, assign) NSInteger *F_DeformityPigCount;
// 总仔数
@property (nonatomic, assign) NSInteger *F_TotalPigCount;
// 有效仔
@property (nonatomic, assign) NSInteger *F_EffectivePigCount;
// 胎龄
@property (nonatomic, assign) NSInteger  *F_ChildCount;
// 总重量
@property (nonatomic, assign) float F_WeightTotal ;
// 平均重量
@property (nonatomic, assign) float F_WeightAverage ;
// 栋舍
@property (nonatomic, copy) NSString *F_PigHouseName;
// 栏位
@property (nonatomic, copy) NSString *F_Field;
// 产房批次
@property (nonatomic, copy) NSString *F_HouseBatch;
// 分娩管理员
@property (nonatomic, copy) NSString *F_OperatePerson;

@end
