//
//  BASemenCollectionDataController.m
//  PigManager
//
//  Created by imac on 2018/7/5.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BASemenCollectionDataController.h"
#import "BASemenCollectionDataCell.h"

@interface BASemenCollectionDataController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) UISearchBar *headerSearchBar;
@property (nonatomic ,strong) UITableView *contentTableView;

@end

@implementation BASemenCollectionDataController
{
    NSInteger page;
}

- (UISearchBar *)headerSearchBar {
    if (!_headerSearchBar) {
        _headerSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 15, KWindowWidth-20, 40)];
        _headerSearchBar.delegate = self;
        _headerSearchBar.placeholder = @"耳标/栋舍";
        _headerSearchBar.layer.cornerRadius = 5.f;
        _headerSearchBar.layer.borderWidth = 0.5f;
        _headerSearchBar.tintColor = [UIResource getffffffColor];
    }
    return _headerSearchBar;
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.headerSearchBar.frame)+10, KWindowWidth-20, KWindowHeight-(NaviHeight)-CGRectGetHeight(self.headerSearchBar.frame)-35)];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIResource getf3f3f3Color];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _contentTableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadSemenCollectionData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    
    [self.view addSubview:self.headerSearchBar];
    [self.view addSubview:self.contentTableView];
}

- (void)loadSemenCollectionData {
//    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
//    [MMProgressHUD showWithStatus:@"正在加载"];
//    NSDictionary *paramDic = @{
//                               @"F_MerchantCode":[UserDefaults objectForKey:MERCHANTCODE],
//                               @"F_PigRecordId":@"",
//                               @"F_OperateTime":@"",
//                               @"F_Quantity":@"",
//                               @"F_QuantityLevel":@"",
//                               @"F_Color":@"",
//                               @"F_ColorLevel":@"",
//                               @"F_Smell":@"",
//                               @"F_SmellLevel":@"",
//                               @"F_Energy":@"",
//                               @"F_EnergyLevel":@"",
//                               @"F_DenSity":@"",
//                               @"F_DenSityLevel":@"",
//                               @"F_Defomity":@"",
//                               @"F_DefomityLevel":@"",
//                               @"F_TotalLevel":@"",
//                               @"F_DeluteLevel":@"",
//                               @"F_DeluteCount":@"",
//                               @"F_OperatePerson":@"",
//                               };
//    NSDictionary *dic = @{
//                          @"Token"    :  [UserDefaults objectForKey:TOKEN],
//                          @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
//                          @"Data"     :  [BANetTool strDic:paramDic]
//                          };
//    [BANetTool postWithUrl:PGGetSex params:dic success:^(id response) {
//        if ([response[@"code"] isEqualToNumber:@(200)]) {
//            [MMProgressHUD dismissWithSuccess:response[@"info"]];
//            // 查询数据
//           [self.contentTableView reloadData];
//        } else {
//            [MMProgressHUD dismissWithError:response[@"info"]];
//        }
//    } fail:^(NSError *error) {
//        [MMProgressHUD dismissWithError:@"网络超时"];
//    }];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"正在加载"];
    NSDictionary *paramDic = @{@"F_MerchantCode":[UserDefaults objectForKey:MERCHANTCODE]};
    NSDictionary *dic = @{
                          @"Token"    :  [UserDefaults objectForKey:TOKEN],
                          @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
                          @"rows": @(10),
                          @"page": @(page),
                          @"Data"     :  [BANetTool strDic:paramDic]
                          };
    [BANetTool postWithUrl:PGPageSexData params:dic success:^(id response) {
        if ([response[@"code"] isEqualToNumber:@(200)]) {
            [MMProgressHUD dismissWithSuccess:response[@"info"]];
            // 查询数据
            [self.contentTableView reloadData];
        } else {
            [MMProgressHUD dismissWithError:response[@"info"]];
        }
    } fail:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"网络超时"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 127.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BASemenCollectionDataCell *cell = [BASemenCollectionDataCell cellWithTableViewCell:self.contentTableView];
    cell.titleDataLabel.text = @"sss";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
