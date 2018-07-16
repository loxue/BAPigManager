//
//  BAPigDieOutBean.h
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAPigDieOutBean : NSObject

// 唯一标号
@property (nonatomic, copy) NSString *F_Id;
// 猪场编号
@property (nonatomic, copy) NSString *F_MerchantCode;
// 猪编号
@property (nonatomic, copy) NSString *F_PigRecordId;
// 死淘类型
@property (nonatomic, copy) NSString *F_DieOutType;
// 死淘原因
@property (nonatomic, copy) NSString *F_DieOutReason;
// 操作人
@property (nonatomic, copy) NSString *F_OperatePerson;
// 操作时间
@property (nonatomic, strong) NSDate *F_OperateTime;

@end
