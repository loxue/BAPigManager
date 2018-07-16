//
//  BAHomeController.m
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAHomeController.h"
#import "SDCycleScrollView.h"
#import "BABannerModel.h"
#import "BAWebViewController.h"
#import "BAPArameterSettingController.h"
#import "BAStaffPerformanceController.h"
#import "BAProductionReportController.h"
#import "BAPopulationDynamicsController.h"
#import "BAImmuneManagementController.h"
#import "BACommodityPManageController.h"
#import "BAPigManagementController.h"
#import "BAPigCalendarController.h"
#import "BADataEntryController.h"
#import "BABannerModel.h"

static NSString *cellId = @"cellHomeID";

@interface BAHomeController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong) NSMutableArray *urlArr;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIView *listView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end

@implementation BAHomeController
{
    UIView *headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight-(NaviHeight)-(TabbarHeight))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIResource getf3f3f3Color];
        _tableView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [[NSMutableArray alloc] init];
    }
    return _bannerArr;
}

- (NSMutableArray *)urlArr {
    if (!_urlArr) {
        _urlArr = [[NSMutableArray alloc] init];
    }
    return _urlArr;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"数据录入", @"养猪日历", @"种猪管理", @"商品猪管理", @"免疫管理", @"存栏动态", @"生产报表", @"员工绩效", @"参数设定"];
    }
    return _titleArray;
}

- (UIView *)listView {
    if (!_listView) {
        _listView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 300)];
        for (int i=0; i<9; i++) {
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            NSArray *imgArr = @[@"shujuluru", @"yangzhurili", @"zhongzhuguanli", @"spzguanli", @"mianyiguanli", @"cunlandongtai", @"shengchanbaobiao", @"yuangongjixiao", @"canshusheding"];
            itemBtn.frame = CGRectMake(((i%3)*(KWindowWidth/3)), ((i/3)*100), (KWindowWidth/3), 100);
            [itemBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
            [itemBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            itemBtn.tag = i;
            [itemBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            itemBtn.titleLabel.font = MXFont12;
            itemBtn.layer.borderWidth = 0.5f;
            itemBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            itemBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
            itemBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 40, 40, 40);
            itemBtn.titleEdgeInsets = UIEdgeInsetsMake(60, -50, 0, 20);
            [itemBtn addTarget:self action:@selector(itemSelectTapped:) forControlEvents:UIControlEventTouchUpInside];
            [_listView addSubview:itemBtn];
        }
    }
    return _listView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    [self loadBannerData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)loadBannerData {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"正在加载"];
    NSDictionary *paramDic = @{@"F_Location":@"1"};
    NSDictionary *dic = @{
                          @"Token"    :  [UserDefaults objectForKey:TOKEN],
                          @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
                          @"Data"     :  [BANetTool strDic:paramDic]
                          };
    [BANetTool postWithUrl:PGCircleImage params:dic success:^(id response) {
        if ([response[@"code"] isEqualToNumber:@(200)]) {
            [MMProgressHUD dismissWithSuccess:response[@"info"]];
            NSArray *banArr = response[@"data"];
            [_bannerArr removeAllObjects];
            for (NSDictionary *subDic in banArr) {
                BABannerModel *model = [BABannerModel mj_objectWithKeyValues:subDic];
                [self.urlArr addObject:model.url];
                [self.bannerArr addObject:model];
            }
            _cycleScrollView.imageURLStringsGroup = self.urlArr;
            [self.tableView reloadData];
        } else {
            [MMProgressHUD dismissWithError:response[@"info"]];
        }
    } fail:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"网络超时"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"猪管家";
    
    [self.view addSubview:self.tableView];
   
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 209)];
    headerView.backgroundColor = [UIResource getffffffColor];
    self.tableView.tableHeaderView = headerView;
    [self setHeaderView];
}

- (void)setHeaderView {
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KWindowWidth, 209) delegate:self placeholderImage:[UIImage imageNamed:@"home_default"]];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.pageDotColor = [UIColor colorWithHEX:@"#ffffff" alpha:0.5];
    _cycleScrollView.autoScrollTimeInterval = 3.f;
    [headerView addSubview:_cycleScrollView];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    BABannerModel *model = _bannerArr[index];
    NSString *url = [NSString stringWithFormat:@"%@", model.url];
    if (![url isEqualToString:@""] && url) {
        BAWebViewController *vc = [[BAWebViewController alloc] init];
        vc.titleStr = model.name;
        vc.url = url;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark list select
- (void)itemSelectTapped:(UIButton *)sender {
    NSArray *controllerNameStr = @[NSStringFromClass([BADataEntryController class]),NSStringFromClass([BAPigCalendarController class]),NSStringFromClass([BAPigManagementController class]),NSStringFromClass([BACommodityPManageController class]),NSStringFromClass([BAImmuneManagementController class]),NSStringFromClass([BAPopulationDynamicsController class]),NSStringFromClass([BAProductionReportController class]),NSStringFromClass([BAStaffPerformanceController class]),NSStringFromClass([BAPArameterSettingController class])];
    UIViewController *vc = [[NSClassFromString(controllerNameStr[sender.tag]) alloc] init];
    vc.title = self.titleArray[sender.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark tab
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:self.listView];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}

@end
