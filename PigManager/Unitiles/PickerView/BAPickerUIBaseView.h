//
//  BAPickerUIBaseView.h
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAPickerViewManager.h"

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/// RGB颜色(16进制)
#define RGB_HEX(rgbValue, a) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:(a)]

@interface BAPickerUIBaseView : UIView
@property (nonatomic , strong) BAPickerViewManager *manager;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

- (void)initUI;

- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;
- (void)clickLeftBtn;
- (void)clickRightBtn;

@end
