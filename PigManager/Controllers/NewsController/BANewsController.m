//
//  BANewsController.m
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BANewsController.h"
#import "BANewsTableViewCell.h"
#import "BAShakeViewController.h"
#import "BANewsModel.h"

static NSString *cellId = @"cellNewsCell";

@interface BANewsController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *newsArr;

@end

@implementation BANewsController

- (NSMutableArray *)newsArr {
    if (!_newsArr) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight-(NaviHeight))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIResource getf3f3f3Color];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"消息", @"附近猪场"]];
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(segmentTapped:) forControlEvents:UIControlEventValueChanged];
     }
    return _segment;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadNewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    
    self.navigationItem.titleView = self.segment;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"摇一摇"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(shakeTapped:)];
    
    [self.view addSubview:self.tableView];

}

- (void)loadNewData {
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
            [self.newsArr removeAllObjects];
            for (NSDictionary *subDic in banArr) {
                BANewsModel *model = [BANewsModel mj_objectWithKeyValues:subDic];
                [self.newsArr addObject:model];
            }
            [self.tableView reloadData];
        } else {
            [MMProgressHUD dismissWithError:response[@"info"]];
        }
    } fail:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"网络超时"];
    }];
}

- (void)shakeTapped:(id)sender {
    BAShakeViewController *vc = [[BAShakeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)segmentTapped:(UISegmentedControl *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    BANewsTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (sender.selectedSegmentIndex==0) {
         cell.cellStyle = BANewCellStyleNews;
    } else {
         cell.cellStyle = BANewCellStylePig;
    }
    [self.tableView reloadData];
}

#pragma mark tab
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BANewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[BANewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    BANewsModel *model = self.newsArr[0];
    BANewsModel *model;
    [cell setModel:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
