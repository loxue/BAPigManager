//
//  BAPigCheckingBean.h
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//  孕检

#import <Foundation/Foundation.h>

@interface BAPigCheckingBean : NSObject

// 唯一标号
@property (nonatomic, copy) NSString *F_Id;
// 猪场编号
@property (nonatomic, copy) NSString *F_MerchantCode;
// 猪编号
@property (nonatomic, copy) NSString *F_PigRecordId;
// 孕检原因
@property (nonatomic, copy) NSString *F_CheckReason;
// 孕检结果
@property (nonatomic, copy) NSString *F_CheckResult;
// 胎龄
@property (nonatomic, copy) NSString *ChildCount;
// 栋舍
@property (nonatomic, copy) NSString *F_PigHouseName;
// 栏位
@property (nonatomic, copy) NSString *F_Field;
// 操作人
@property (nonatomic, copy) NSString *F_OperatePerson;
// 操作日期
@property (nonatomic, copy) NSString *F_OperateTime;

@end
