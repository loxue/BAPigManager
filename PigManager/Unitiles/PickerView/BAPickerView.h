//
//  BAPickerView.h
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BAPickerViewManager.h"
#import <UIKit/UIKit.h>

typedef void(^BAAddressResultBlock)(NSArray *selectAddressArr,NSArray *selectAddressRow);
typedef void(^BADateResultBlock)(NSString *selectValue);
typedef void(^BAStringResultBlock)(id selectValue,id selectRow);

typedef NS_ENUM(NSInteger, BAStringPickerViewStyle) {
    BAStringPickerViewStylePigHouseInfo,   //猪舍信息
    BAStringPickerViewStylePigBatch,       //批次
    BAStringPickerViewStyleWeek,   //星期
    BAStringPickerViewStyleGender, //性别
    BAStringPickerViewStylePigKind,   //猪种类
    BAStringPickerViewStylePigHouse,  //猪舍
    BAStringPickerViewStylePigGroup,  //猪类别
    BAStringPickerViewStylePigInfo,   //猪信息
    BAStringPickerViewStyleBreedingPigInfo,   //种猪信息
};

@interface BAPickerView : NSObject

+ (void)showAddressPickerWithTitle:(NSString *)title
                   DefaultSelected:(NSArray *)defaultSelectedArr
                      IsAutoSelect:(BOOL)isAutoSelect
                           Manager:(BAPickerViewManager *)manager
                       ResultBlock:(BAAddressResultBlock)resultBlock;


+ (void)showAddressPickerWithTitle:(NSString *)title
                   DefaultSelected:(NSArray *)defaultSelectedArr
                          FileName:(NSString *)fileName
                      IsAutoSelect:(BOOL)isAutoSelect
                           Manager:(BAPickerViewManager *)manager
                       ResultBlock:(BAAddressResultBlock)resultBlock;

+ (void)showDatePickerWithTitle:(NSString *)title
                       DateType:(UIDatePickerMode)type
                DefaultSelValue:(NSString *)defaultSelValue
                     MinDateStr:(NSString *)minDateStr
                     MaxDateStr:(NSString *)maxDateStr
                   IsAutoSelect:(BOOL)isAutoSelect
                        Manager:(BAPickerViewManager *)manager
                    ResultBlock:(BADateResultBlock)resultBlock;

+ (void)showStringPickerWithTitle:(NSString *)title
                       DataSource:(NSArray *)dataSource
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                          Manager:(BAPickerViewManager *)manager
                      ResultBlock:(BAStringResultBlock)resultBlock;

+ (void)showStringPickerWithTitle:(NSString *)title
                        FileName:(NSString *)fileName
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                          Manager:(BAPickerViewManager *)manager
                      ResultBlock:(BAStringResultBlock)resultBlock;

+ (void)showStringPickerWithTitle:(NSString *)title
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                          Manager:(BAPickerViewManager *)manager
                      ResultBlock:(BAStringResultBlock)resultBlock
                            Style:(BAStringPickerViewStyle)style;

+ (NSArray *)showStringPickerDataSourceStyle:(BAStringPickerViewStyle)style;
+ (NSString *)showSelectAddressProvince_id:(NSString *)province_id City_id:(NSString *)city_id;

@end
