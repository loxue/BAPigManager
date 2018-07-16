//
//  BAPickerViewManager.m
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAPickerViewManager.h"

@interface BAPickerViewManager ()

@end
@implementation BAPickerViewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _kPickerViewH = 200;
        _kTopViewH = 50;
        _pickerTitleSize  =15;
        _pickerTitleColor = [UIColor blackColor];
        _lineViewColor = BAPickerRGBColor(225, 225, 225, 1);
        
        _titleLabelColor = [UIResource get0faae2Color];
        _titleSize = 16;
        _titleLabelBGColor = [UIColor whiteColor];
        
        _rightBtnTitle = @"确定";
        _rightBtnBGColor = [UIResource get0faae2Color];
        _rightBtnTitleSize = 16;
        _rightBtnTitleColor = [UIColor whiteColor];
        
        _rightBtnborderColor = [UIResource get0faae2Color];
        _rightBtnCornerRadius = 6;
        _rightBtnBorderWidth = 0.5f;
        
        _leftBtnTitle = @"取消";
        _leftBtnBGColor = [UIResource get0faae2Color];
        _leftBtnTitleSize = 16;
        _leftBtnTitleColor = [UIColor whiteColor];
        
        _leftBtnborderColor = [UIResource get0faae2Color];
        _leftBtnCornerRadius = 6;
        _leftBtnBorderWidth = 0.5f;
        
    }
    return self;
}
@end
