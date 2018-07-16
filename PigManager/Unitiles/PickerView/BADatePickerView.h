//
//  BADatePickerView.h
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAPickerUIBaseView.h"


typedef void(^BADateResultBlock)(NSString *selectValue);

@interface BADatePickerView : BAPickerUIBaseView

+ (void)showDatePickerWithTitle:(NSString *)title
                       DateType:(UIDatePickerMode)type
                DefaultSelValue:(NSString *)defaultSelValue
                     MinDateStr:(NSString *)minDateStr
                     MaxDateStr:(NSString *)maxDateStr
                   IsAutoSelect:(BOOL)isAutoSelect
                    ResultBlock:(BADateResultBlock)resultBlock;

+ (void)showDatePickerWithTitle:(NSString *)title
                       DateType:(UIDatePickerMode)type
                DefaultSelValue:(NSString *)defaultSelValue
                     MinDateStr:(NSString *)minDateStr
                     MaxDateStr:(NSString *)maxDateStr
                   IsAutoSelect:(BOOL)isAutoSelect
                    ResultBlock:(BADateResultBlock)resultBlock
                        Manager:(BAPickerViewManager *)manager;

@end
