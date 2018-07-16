//
//  BAMeController.m
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAMeController.h"
#import "BALoginController.h"
#import "BACreatePigFarmController.h"

static NSString *cellId = @"cellMe";

@interface BAMeController ()<UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) NSArray *section0;
@property (nonatomic, strong) NSArray *section1;
@property (nonatomic, strong) NSArray *section2;
@end

@implementation BAMeController
{
    UIView *footerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight-(NaviHeight)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [self footer];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIResource getf3f3f3Color];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadPigInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    [self.view addSubview:self.tableView];
    
    _section0 = @[@"姓名", @"联系电话", @"修改密码"];
    _section1 = @[@"建立猪场账户", @"猪场录入员权限申请", @"查看猪场", @"使用说明"];
    _section2 = @[@"联系我们", @"关于我们"];
    _listArr = [NSMutableArray array];
    [_listArr addObject:_section0];
    [_listArr addObject:_section1];
    [_listArr addObject:_section2];
    
}

- (UIView *)footer {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 80)];
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(10, 36, KWindowWidth-20, 44);
    [footBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [footBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footBtn addTarget:self action:@selector(loginOutTapped:) forControlEvents:UIControlEventTouchUpInside];
    [footBtn setBackgroundColor:[UIResource get0faae2Color]];
    footBtn.layer.cornerRadius = 5;
    [view addSubview:footBtn];
    return view;
}

#pragma mark tab
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return _section0.count;
    } else if (section==1) {
        return _section1.count;
    } else {
        return _section2.count;
    }
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
    cell.textLabel.text = (indexPath.section==0)?_section0[indexPath.row]:((indexPath.section==1)?_section1[indexPath.row]:_section2[indexPath.row]);
    cell.imageView.image = [UIImage imageNamed:@""];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray *controllerNameStr = @[NSStringFromClass([BADataEntryController class]),NSStringFromClass([BAPigCalendarController class]),NSStringFromClass([BAPigManagementController class]),NSStringFromClass([BACommodityPManageController class]),NSStringFromClass([BAImmuneManagementController class]),NSStringFromClass([BAPopulationDynamicsController class]),NSStringFromClass([BAProductionReportController class]),NSStringFromClass([BAStaffPerformanceController class]),NSStringFromClass([BAPArameterSettingController class])];
//    UIViewController *vc = [[NSClassFromString(controllerNameStr[sender.tag]) alloc] init];
//    vc.title = self.titleArray[sender.tag];
//    [self.navigationController pushViewController:vc animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                {
                    
                }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                {
                    BACreatePigFarmController *vc = [[BACreatePigFarmController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                break;
                
            default:
                break;
        }
    } else {
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 10.f)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 1.f)];
}

#pragma mark - 请求数据
- (void)loadPigInfo {
    BALog(@"加载猪场信息接口、、、、、");
}

- (void)loginOutTapped:(UIButton *)sender {
    [UserDefaults setBool:NO forKey:ISLOGIN];
    [UserDefaults synchronize];
    
    BALoginController *vc = [[BALoginController alloc] init];
    UIViewController *nav = [[BANavigationController alloc] initWithRootViewController:vc];
    vc.vcindex = @"2";
    KWindow.rootViewController = nav;
}

@end
