//
//  BAPickerView.m
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAPickerView.h"
#import "BAStringPickerView.h"
#import "BADatePickerView.h"
#import "BAAddressPcikerView.h"

@implementation BAPickerView

+ (void)showStringPickerWithTitle:(NSString *)title
                         FileName:(NSString *)fileName
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                         Manager:(BAPickerViewManager *)manager
                      ResultBlock:(BAStringResultBlock)resultBlock
{
    [BAStringPickerView showStringPickerWithTitle:title
                                          FileName:fileName
                                   DefaultSelValue:defaultSelValue
                                      IsAutoSelect:isAutoSelect
                                           Manager:(BAPickerViewManager *)manager
                                       ResultBlock:^(id selectValue, id selectRow) {
        if (resultBlock) {
            resultBlock(selectValue,selectRow);
        };
    }];
}

+ (void)showStringPickerWithTitle:(NSString *)title
                       DataSource:(NSArray *)dataSource
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                          Manager:(BAPickerViewManager *)manager
                      ResultBlock:(BAStringResultBlock)resultBlock
{
    [BAStringPickerView showStringPickerWithTitle:title
                                        DataSource:dataSource
                                   DefaultSelValue:defaultSelValue
                                      IsAutoSelect:isAutoSelect
                                           Manager:(BAPickerViewManager *)manager
                                       ResultBlock:^(id selectValue, id selectRow) {
                                           if (resultBlock) {
                                               resultBlock(selectValue,selectRow);
                                           } ;
    }];
}

+ (void)showStringPickerWithTitle:(NSString *)title
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                         Manager:(BAPickerViewManager *)manager
                      ResultBlock:(BAStringResultBlock)resultBlock
                            Style:(BAStringPickerViewStyle)style
{
    [BAStringPickerView showStringPickerWithTitle:title
                                   DefaultSelValue:defaultSelValue
                                      IsAutoSelect:isAutoSelect
                                           Manager:(BAPickerViewManager *)manager
                                       ResultBlock:^(id selectValue, id selectRow) {
                                           if (resultBlock) {
                                               resultBlock(selectValue,selectRow);
                                           } ;
    } Style:style];
}

+ (NSArray *)showStringPickerDataSourceStyle:(BAStringPickerViewStyle)style
{
    NSArray *dataSource =[NSArray array];
    
    if (style == BAStringPickerViewStylePigHouseInfo ||
        style == BAStringPickerViewStylePigBatch ||
        style == BAStringPickerViewStyleWeek ||
        style == BAStringPickerViewStyleGender ||
        style == BAStringPickerViewStylePigKind ||
        style == BAStringPickerViewStylePigHouse ||
        style == BAStringPickerViewStylePigGroup ||
        style == BAStringPickerViewStylePigInfo ||
        style == BAStringPickerViewStyleBreedingPigInfo ) {
        dataSource = [BAStringPickerView showStringPickerDataSourceStyle:style];
    }
    
    return dataSource;
}


+ (void)showDatePickerWithTitle:(NSString *)title
                       DateType:(UIDatePickerMode)type
                DefaultSelValue:(NSString *)defaultSelValue
                     MinDateStr:(NSString *)minDateStr
                     MaxDateStr:(NSString *)maxDateStr
                   IsAutoSelect:(BOOL)isAutoSelect
                        Manager:(BAPickerViewManager *)manager
                    ResultBlock:(BADateResultBlock)resultBlock
{
    if (manager) {
        [BADatePickerView showDatePickerWithTitle:title
                                          DateType:type
                                   DefaultSelValue:defaultSelValue
                                        MinDateStr:minDateStr
                                        MaxDateStr:maxDateStr
                                      IsAutoSelect:isAutoSelect
                                       ResultBlock:^(NSString *selectValue) {
            if (resultBlock) {
                resultBlock(selectValue);
            }
        } Manager:manager];
    } else{
        [BADatePickerView showDatePickerWithTitle:title
                                          DateType:type
                                   DefaultSelValue:defaultSelValue
                                        MinDateStr:minDateStr
                                        MaxDateStr:maxDateStr
                                      IsAutoSelect:isAutoSelect
                                       ResultBlock:^(NSString *selectValue) {
            if (resultBlock) {
                resultBlock(selectValue);
            }
        }];
    }

}
+ (void)showAddressPickerWithTitle:(NSString *)title
                   DefaultSelected:(NSArray *)defaultSelectedArr
                      IsAutoSelect:(BOOL)isAutoSelect
                           Manager:(BAPickerViewManager *)manager
                       ResultBlock:(BAAddressResultBlock)resultBlock
{
    [BAAddressPcikerView showAddressPickerWithTitle:title DefaultSelected:defaultSelectedArr IsAutoSelect:isAutoSelect Manager:manager ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
        if (resultBlock) {
            resultBlock(selectAddressArr,selectAddressRow);
        }; ;
    }];
}

+ (void)showAddressPickerWithTitle:(NSString *)title
                   DefaultSelected:(NSArray *)defaultSelectedArr
                          FileName:(NSString *)fileName
                      IsAutoSelect:(BOOL)isAutoSelect
                           Manager:(BAPickerViewManager *)manager
                       ResultBlock:(BAAddressResultBlock)resultBlock
{
    [BAAddressPcikerView showAddressPickerWithTitle:title DefaultSelected:defaultSelectedArr FileName:fileName IsAutoSelect:isAutoSelect Manager:manager ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
        if (resultBlock) {
            resultBlock(selectAddressArr,selectAddressRow);
        }; ;
    }];
}

+ (NSString *)showSelectAddressProvince_id:(NSString *)province_id City_id:(NSString *)city_id {
    NSString *mulStr = @"不限";
    NSMutableArray *arrData = [NSMutableArray array];
    NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"BAPickerView" ofType:@"bundle"];
    NSString *filePath = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"BAAddressCity" ofType:@"plist"];
    arrData = [NSMutableArray arrayWithContentsOfFile:filePath];
    NSInteger inter1= [province_id integerValue];
    NSInteger inter2= [city_id integerValue];
    if (![province_id isEqualToString:@"0"]) {
        NSDictionary *dict1 = arrData[inter1];
        mulStr =[dict1 objectForKey:@"v"];
        NSArray *arr = [dict1 objectForKey:@"n"];
        if (![city_id isEqualToString:@"0"]) {
            NSDictionary *dict2 = arr[inter2];
            mulStr = [NSString stringWithFormat:@"%@-%@",mulStr,[dict2 objectForKey:@"v"]];
        }
    }
    return mulStr;
    
}

@end
