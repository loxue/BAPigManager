//
//  BADataEntryController.m
//  PigManager
//  马彦春
//  Created by imac on 2018/6/12.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BADataEntryController.h"
#import "BASaveOperationController.h"
#import "BACommercialPigDataSearchController.h"
#import "BABreedingPigSearchController.h"
#import "BACommercialPigBatchController.h"
#import "BACommercialPigHouseController.h"
#import "BADeadAmoyDataController.h"
#import "BAWeaningDataController.h"
#import "BAChildbirthController.h"
#import "BAPregnancyTestController.h"
#import "BABreedingDataController.h"
#import "BASemenCollectionDataController.h"
#import "BABreedingPigNewBuildingController.h"
#import "BAAddBreedingPigController.h"

static NSString *cellId = @"cellI";

@interface BADataEntryController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) NSArray *imageArr;
@end

@implementation BADataEntryController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight-(NaviHeight))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIResource getf3f3f3Color];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@"添加新种猪", @"添加种猪新栋社", @"采精数据录入", @"配种数据录入", @"孕检数据录入", @"分娩数据录入", @"断奶数据录入", @"死淘数据录入", @"添加商品猪新栋社", @"添加商品猪新批次", @"种猪录入数据查询与修改", @"商品猪录入数据查询与修改", @"盘存操作"];
    }
    return _listArr;
}

- (NSArray *)imageArr {
    if (!_imageArr) {
        _imageArr = @[@"tjxzz", @"tjzzxds", @"cjsjlr", @"pzsjlr", @"yjsjlr", @"fmsjlr", @"dnsjlr", @"stsjlr", @"tjspzxds", @"tjspzxpc", @"zzlrsjcxyxg", @"spzlrsjcxyxg", @"cpcz"];
    }
    return _imageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableView];
}

#pragma mark tab
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.listArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *controllerNameStr = @[NSStringFromClass([BAAddBreedingPigController class]),NSStringFromClass([BABreedingPigNewBuildingController class]),NSStringFromClass([BASemenCollectionDataController class]),NSStringFromClass([BABreedingDataController class]),NSStringFromClass([BAPregnancyTestController class]),NSStringFromClass([BAChildbirthController class]),NSStringFromClass([BAWeaningDataController class]),NSStringFromClass([BADeadAmoyDataController class]),NSStringFromClass([BACommercialPigHouseController class]),NSStringFromClass([BACommercialPigBatchController class]),NSStringFromClass([BABreedingPigSearchController class]),NSStringFromClass([BACommercialPigDataSearchController class]),NSStringFromClass([BASaveOperationController class])];
    UIViewController *vc = [[NSClassFromString(controllerNameStr[indexPath.row]) alloc] init];
    vc.title = self.listArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
