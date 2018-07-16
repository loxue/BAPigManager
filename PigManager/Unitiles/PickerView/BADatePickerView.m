//
//  BADatePickerView.m
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BADatePickerView.h"

@interface BADatePickerView ()
{
    UIDatePickerMode _datePickerMode;
    NSString *_title;
    NSString *_minDateStr;
    NSString *_maxDateStr;
    BADateResultBlock _resultBlock;
    NSString *_selectValue;
    BOOL _isAutoSelect;  // 是否开启自动选择
}

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation BADatePickerView

#pragma mark - 显示时间选择器
+ (void)showDatePickerWithTitle:(NSString *)title
                       DateType:(UIDatePickerMode)type
                DefaultSelValue:(NSString *)defaultSelValue
                     MinDateStr:(NSString *)minDateStr
                     MaxDateStr:(NSString *)maxDateStr
                   IsAutoSelect:(BOOL)isAutoSelect
                    ResultBlock:(BADateResultBlock)resultBlock
{
    BADatePickerView *datePickerView = [[BADatePickerView alloc]initWithTitle:title DateType:type DefaultSelValue:defaultSelValue MinDateStr:(NSString *)minDateStr MaxDateStr:(NSString *)maxDateStr IsAutoSelect:isAutoSelect ResultBlock:resultBlock Manager:nil];
    [datePickerView showWithAnimation:YES];
}
+ (void)showDatePickerWithTitle:(NSString *)title
                       DateType:(UIDatePickerMode)type
                DefaultSelValue:(NSString *)defaultSelValue
                     MinDateStr:(NSString *)minDateStr
                     MaxDateStr:(NSString *)maxDateStr
                   IsAutoSelect:(BOOL)isAutoSelect
                    ResultBlock:(BADateResultBlock)resultBlock
                        Manager:(BAPickerViewManager *)manager
{
    BADatePickerView *datePickerView = [[BADatePickerView alloc]initWithTitle:title DateType:type DefaultSelValue:defaultSelValue MinDateStr:(NSString *)minDateStr MaxDateStr:(NSString *)maxDateStr IsAutoSelect:isAutoSelect ResultBlock:resultBlock Manager:manager];
    [datePickerView showWithAnimation:YES];
}

#pragma mark - 初始化时间选择器
- (instancetype)initWithTitle:(NSString *)title
                     DateType:(UIDatePickerMode)type
              DefaultSelValue:(NSString *)defaultSelValue
                   MinDateStr:(NSString *)minDateStr
                   MaxDateStr:(NSString *)maxDateStr
                 IsAutoSelect:(BOOL)isAutoSelect
                  ResultBlock:(BADateResultBlock)resultBlock
                      Manager:(BAPickerViewManager *)manager
{
    if (self = [super init]) {
        _datePickerMode = type;
        _title = title;
        _minDateStr = minDateStr;
        _maxDateStr = maxDateStr;
        _isAutoSelect = isAutoSelect;
        _resultBlock = resultBlock;
        
        if (manager) {
            self.manager = manager;
        }
        // 默认选中今天的日期
        if (defaultSelValue.length > 0) {
            _selectValue = defaultSelValue;
        } else {
            _selectValue = [self toStringWithDate:[NSDate date]];
        }
        
        [self initUI];
    }
    return self;
}

#pragma mark - 初始化子视图
- (void)initUI {
    [super initUI];
    self.titleLabel.text = _title;
    // 添加时间选择器
    [self.alertView addSubview:self.datePicker];
}

#pragma mark - 时间选择器
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.manager.kTopViewH + 0.5, SCREEN_WIDTH, self.manager.kPickerViewH)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = _datePickerMode;
        _datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CHS_CN"];
        // 设置时间范围
        if (_minDateStr) {
            NSDate *minDate = [self toDateWithDateString:_minDateStr];
            _datePicker.minimumDate = minDate;
        }
        if (_maxDateStr) {
            NSDate *maxDate = [self toDateWithDateString:_maxDateStr];
            _datePicker.maximumDate = maxDate;
        }
        // 把当前时间赋值给 _datePicker
        [_datePicker setDate:[NSDate date] animated:YES];
//        [_datePicker setLocale:[NSLocale systemLocale]];
        // 设置时区
//        [_datePicker setTimeZone:[NSTimeZone localTimeZone]];
//        // 设置UIDatePicker的显示模式
        // 滚动改变值的响应事件
        [_datePicker addTarget:self action:@selector(didSelectValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.alertView.frame = rect;
        
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= self.manager.kTopViewH + self.manager.kPickerViewH;
            self.alertView.frame = rect;
        }];
    }
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += self.manager.kTopViewH + self.manager.kPickerViewH;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 时间选择器的滚动响应事件
- (void)didSelectValueChanged:(UIDatePicker *)sender {
    // 读取日期：datePicker.date
    _selectValue = [self toStringWithDate:sender.date];
    NSLog(@"滚动完成后，执行block回调:%@", _selectValue);
    // 设置是否开启自动回调
    if (_isAutoSelect) {
        if (_resultBlock) {
            _resultBlock(_selectValue);
        }
    }
}

#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {
    [self dismissWithAnimation:YES];
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
    NSLog(@"点击确定按钮后，执行block回调");
    [self dismissWithAnimation:YES];
    if (_resultBlock) {
        _resultBlock(_selectValue);
    }
}

#pragma mark - 格式转换：NSDate --> NSString
- (NSString *)toStringWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (_datePickerMode) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

#pragma mark - 格式转换：NSDate <-- NSString
- (NSDate *)toDateWithDateString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (_datePickerMode) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
}

@end
