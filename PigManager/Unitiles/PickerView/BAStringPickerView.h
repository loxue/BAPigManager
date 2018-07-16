//
//  BAStringPickerView.h
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAPickerUIBaseView.h"

typedef void(^BAStringResultBlock)(id selectValue,id selectRow);

@interface BAStringPickerView : BAPickerUIBaseView

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
                            Style:(NSInteger)style;

+ (NSArray *)showStringPickerDataSourceStyle:(NSInteger)style;

@end
