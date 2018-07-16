//
//  BAPigMatingBean.h
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAPigMatingBean : NSObject

// 唯一标号
@property (nonatomic, copy) NSString *F_Id;

// 猪场编号
@property (nonatomic, copy) NSString *F_MerchantCode;

// 猪编号
@property (nonatomic, copy) NSString *F_PigRecordId;

// 一配时间
@property (nonatomic, copy) NSString *F_OneMatingTime;
@property (nonatomic, assign) long oneMatingTime;

// 一配公猪
@property (nonatomic, copy) NSString *F_OneMatingBoar;

// 二配时间
@property (nonatomic, copy) NSString *F_TwoMatingTime;
@property (nonatomic, assign) long twoMatingTime;

// 二配公猪
@property (nonatomic, copy) NSString *F_TwoMatingBoar;

// 预产期
@property (nonatomic, copy) NSString *F_ChildTime;
@property (nonatomic, assign) long childMatingTime;

// 胎龄
@property (nonatomic, assign) int F_ChildCount;

// 栋舍名称
@property (nonatomic, copy) NSString *F_PigHouseName;

// 栏位
@property (nonatomic, copy) NSString *F_Field;

// 操作人
@property (nonatomic, copy) NSString *F_OperatePerson;

@end
