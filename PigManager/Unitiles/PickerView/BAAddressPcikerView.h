//
//  BAAddressPcikerView.h
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAPickerUIBaseView.h"

typedef void(^BAAddressResultBlock)(NSArray *selectAddressArr,NSArray *selectAddressRow);

@interface BAAddressPcikerView : BAPickerUIBaseView

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

@end
