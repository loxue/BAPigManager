//
//  BAProductionReportController.m
//  PigManager
//  马彦春
//  Created by imac on 2018/6/12.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAProductionReportController.h"

static NSString *cellId = @"cellI4677";

@interface BAProductionReportController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@end

@implementation BAProductionReportController

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
        _listArr = @[@"生产日报", @"周/月/年综合报表", @"母猪实时状态", @"母猪胎龄结构", @"种猪淘汰表", @"预计分娩窝数", @"公猪精液生产报表", @"公猪生产成绩报表", @"配种进度报表", @"种猪周批次生产进度表", @"非生产天数报表", @"空反流原因分析表", @"分娩报表", @"胎次-产仔数相关性分析表", @"断奶报表", @"PSY", @"产房仔猪报表", @"保育猪报表", @"育肥猪报表", @"育成猪报表", @"环比月报", @"场间对比报表"];
    }
    return _listArr;
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
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.listArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
