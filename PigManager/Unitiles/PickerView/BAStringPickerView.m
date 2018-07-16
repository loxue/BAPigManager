//
//  BAStringPickerView.m
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAStringPickerView.h"

@interface BAStringPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) BOOL isSingleColumn;
@property (nonatomic, assign) BOOL isDataSourceValid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray  *dataSource;
@property (nonatomic, assign) BOOL isAutoSelect;
@property (nonatomic, copy) BAStringResultBlock resultBlock;

@property (nonatomic, copy) NSString *selectedItem;
@property (nonatomic, strong) NSMutableArray *selectedItems;

@end

@implementation BAStringPickerView

#pragma mark - 显示自定义字符串选择器
+ (void)showStringPickerWithTitle:(NSString *)title
                       DataSource:(NSArray *)dataSource
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                          Manager:(BAPickerViewManager *)manager
                      ResultBlock:(BAStringResultBlock)resultBlock
{
    if (dataSource == nil || dataSource.count == 0) {
        return;
    }
    BAStringPickerView *strPickerView = [[BAStringPickerView alloc] initWithTitle:title
                                                                       DataSource:dataSource
                                                                  DefaultSelValue:defaultSelValue
                                                                    IisAutoSelect:isAutoSelect
                                                                          Manager:manager
                                                                      ResultBlock:resultBlock];
     [strPickerView showWithAnimation:YES];
}
+ (void)showStringPickerWithTitle:(NSString *)title
                         FileName:(NSString *)fileName
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                          Manager:(BAPickerViewManager *)manager
                      ResultBlock:(BAStringResultBlock)resultBlock
 {
    if (fileName == nil || fileName.length == 0) {
        return;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSArray *dataSource =[[NSArray alloc] initWithContentsOfFile:path];
    BAStringPickerView *strPickerView = [[BAStringPickerView alloc] initWithTitle:title
                                                                       DataSource:dataSource
                                                                  DefaultSelValue:defaultSelValue
                                                                    IisAutoSelect:isAutoSelect
                                                                          Manager:manager
                                                                      ResultBlock:resultBlock];
     [strPickerView showWithAnimation:YES];
}
+ (void)showStringPickerWithTitle:(NSString *)title
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                          Manager:(BAPickerViewManager *)manager
                      ResultBlock:(BAStringResultBlock)resultBlock
                            Style:(NSInteger)style
{
    NSArray *dataSource = [BAStringPickerView showStringPickerDataSourceStyle:style];
    
   BAStringPickerView *strPickerView = [[BAStringPickerView alloc] initWithTitle:title
                                                                      DataSource:dataSource
                                                                 DefaultSelValue:defaultSelValue
                                                                   IisAutoSelect:isAutoSelect
                                                                         Manager:manager
                                                                     ResultBlock:resultBlock];
    [strPickerView showWithAnimation:YES];
}

+ (NSArray *)showStringPickerDataSourceStyle:(NSInteger)style
{
    NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"BAPickerView" ofType:@"bundle"];
    NSString *filePath = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"BABasicInfoPicker" ofType:@"plist"];
    NSMutableDictionary *dataSourceaa = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *dataSource = [NSArray array];
    
    switch (style) {
        case 0:
            {
                dataSource = [dataSourceaa objectForKey:@"pighouseinfo"];
            }
            break;
        case 1:
            {
                dataSource = [dataSourceaa objectForKey:@"pigbatch"];
            }
            break;
        case 2:
            {
                dataSource = [dataSourceaa objectForKey:@"week"];
            }
            break;
        case 3:
            {
                dataSource = [dataSourceaa objectForKey:@"gender"];
            }
            break;
        case 4:
            {
                dataSource = [dataSourceaa objectForKey:@"pigkind"];
            }
            break;
        case 5:
            {
                dataSource = [dataSourceaa objectForKey:@"pighouse"];
            }
            break;
        case 6:
            {
                dataSource = [dataSourceaa objectForKey:@"piggroup"];
            }
            break;
        case 7:
            {
                dataSource = [dataSourceaa objectForKey:@"piginfo"];
            }
            break;
        case 8:
            {
                dataSource = [dataSourceaa objectForKey:@"breedingpiginfo"];
            }
        default:
            break;
    }
    NSLog(@"style %ld--%@" , style,dataSourceaa);
    return dataSource;
}

#pragma mark - 初始化自定义字符串选择器
- (instancetype)initWithTitle:(NSString *)title
                   DataSource:(NSArray *)dataSource
              DefaultSelValue:(id)defaultSelValue
                 IisAutoSelect:(BOOL)isAutoSelect
                     Manager:(BAPickerViewManager *)manager
                  ResultBlock:(BAStringResultBlock)resultBlock
{
    if (self = [super init]) {
        self.title = title;
        self.dataSource = dataSource;
        self.isAutoSelect = isAutoSelect;
        self.resultBlock = resultBlock;
        
        if (defaultSelValue) {
            if ([defaultSelValue isKindOfClass:[NSString class]]) {
                self.selectedItem = defaultSelValue;
            } else if ([defaultSelValue isKindOfClass:[NSArray class]]){
                self.selectedItems = [defaultSelValue mutableCopy];
            }
        }
        [self loadData];
        [self initUI];
    }
    return self;
}

#pragma mark - 初始化子视图
- (void)initUI {
    [super initUI];
    self.titleLabel.text = self.title;
    // 添加字符串选择器
    [self.alertView addSubview:self.pickerView];
}

#pragma mark - 加载自定义字符串数据
- (void)loadData {
    if (self.dataSource == nil || self.dataSource.count == 0) {
        self.isDataSourceValid = NO;
        return;
    } else {
        self.isDataSourceValid = YES;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        static Class itemType;
        if (idx == 0) {
            itemType = [obj class];
            // 判断数据源数组的第一个元素是什么类型
            if ([obj isKindOfClass:[NSArray class]]) {
                weakSelf.isSingleColumn = NO; // 非单列
            } else if ([obj isKindOfClass:[NSString class]]) {
                weakSelf.isSingleColumn = YES; // 单列
            } else {
                weakSelf.isDataSourceValid = NO;
                return;
            }
        } else {
            // 判断数组的元素类型是否相同
            if (itemType != [obj class]) {
                weakSelf.isDataSourceValid = NO;
                *stop = YES;
                return;
            }
            
            if ([obj isKindOfClass:[NSArray class]]) {
                if (((NSArray *)obj).count == 0) {
                    weakSelf.isDataSourceValid = NO;
                    *stop = YES;
                    return;
                } else {
                    for (id subObj in obj) {
                        if (![subObj isKindOfClass:[NSString class]]) {
                            weakSelf.isDataSourceValid = NO;
                            *stop = YES;
                            return;
                        }
                    }
                }
            }
        }
    }];
    
    if (self.isSingleColumn) {
        if (self.selectedItem == nil) {
            // 如果是单列，默认选中数组第一个元素
            self.selectedItem = _dataSource.firstObject;
        }
    } else {
        BOOL isSelectedItemsValid = YES;
        for (id obj in self.selectedItems) {
            if (![obj isKindOfClass:[NSString class]]) {
                isSelectedItemsValid = NO;
                break;
            }
        }
        if (self.selectedItems == nil || self.selectedItems.count != self.dataSource.count || !isSelectedItemsValid) {
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (NSArray* componentItem in _dataSource) {
                [mutableArray addObject:componentItem.firstObject];
            }
            self.selectedItems = [NSMutableArray arrayWithArray:mutableArray];
        }
    }
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

#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {
    [self dismissWithAnimation:YES];
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
//    NSLog(@"点击确定按钮后，执行block回调");
    [self dismissWithAnimation:YES];
    if(_resultBlock) {
        if (self.isSingleColumn) {
            NSString  *str = [NSString stringWithFormat:@"%ld",[_dataSource indexOfObject:self.selectedItem]];
                _resultBlock([self.selectedItem copy],[str copy]);
        } else {
            NSMutableArray *selectRowAry = [NSMutableArray array];
            for (int i = 0; i<_dataSource.count; i++) {
                NSArray *arr = _dataSource[i];
                NSString *str = self.selectedItems[i];
                [selectRowAry addObject:[NSString stringWithFormat:@"%ld" , [arr indexOfObject:str]]];
            }
                _resultBlock([self.selectedItems copy],[selectRowAry copy]);
        }
    }
}

#pragma mark - 字符串选择器
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.manager.kTopViewH + 0.5, SCREEN_WIDTH, self.manager.kPickerViewH)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        
        __weak typeof(self) weakSelf = self;
        if (self.isSingleColumn) {
            [_dataSource enumerateObjectsUsingBlock:^(NSString *rowItem, NSUInteger rowIdx, BOOL *stop) {
                if ([weakSelf.selectedItem isEqualToString:rowItem]) {
                    [weakSelf.pickerView selectRow:rowIdx inComponent:0 animated:NO];
                    *stop = YES;
                }
            }];
        } else {
            [self.selectedItems enumerateObjectsUsingBlock:^(NSString *selectedItem, NSUInteger component, BOOL *stop) {
                [_dataSource[component] enumerateObjectsUsingBlock:^(id rowItem, NSUInteger rowIdx, BOOL *stop) {
                    if ([selectedItem isEqualToString:rowItem]) {
                        [weakSelf.pickerView selectRow:rowIdx inComponent:component animated:NO];
                        *stop = YES;
                    }
                }];
            }];
        }
    }
    return _pickerView;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.isSingleColumn) {
        return 1;
    } else {
        return _dataSource.count;
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.isSingleColumn) {
        return _dataSource.count;
    } else {
        return ((NSArray*)_dataSource[component]).count;
    }
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.isSingleColumn) {
        return _dataSource[row];
    } else {
        return ((NSArray*)_dataSource[component])[row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.isSingleColumn) {
        self.selectedItem = _dataSource[row];
    } else {
        self.selectedItems[component] = ((NSArray *)_dataSource[component])[row];
    }
    // 设置是否自动回调
    if (self.isAutoSelect) {
        if(_resultBlock) {
            if (self.isSingleColumn) {
                NSString  *str = [NSString stringWithFormat:@"%ld",[_dataSource indexOfObject:self.selectedItem]];
                    _resultBlock([self.selectedItem copy],[str copy]);
            } else {
                NSMutableArray *selectRowAry = [NSMutableArray array];
                for (int i = 0; i<_dataSource.count; i++) {
                    NSArray *arr = _dataSource[i];
                    NSString *str = self.selectedItems[i];
                    [selectRowAry addObject:[NSString stringWithFormat:@"%ld" , [arr indexOfObject:str]]];
                }
                _resultBlock([self.selectedItems copy],[selectRowAry copy]);
            }
        }
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        }
    }
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 30) / 3, 40)];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor whiteColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:self.manager.pickerTitleSize]];
        [pickerLabel setTextColor:self.manager.pickerTitleColor];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


@end
