//
//  BABreedingPigNewBuildingController.m
//  PigManager
//
//  Created by imac on 2018/7/5.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BABreedingPigNewBuildingController.h"
#import "BAPigHouseModel.h"

static NSString *cellId = @"cellBreedingPNBID";

@interface BABreedingPigNewBuildingController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *leftScrollView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSArray *pigHouseArr;
@property (nonatomic, strong) NSMutableArray *addPigHouseArr;
@property (nonatomic, strong) UIButton *tempBtn;
@end

@implementation BABreedingPigNewBuildingController
{
    NSString *headerFirstStr, *headerFourthStr, *buttonMarkString, *itemString, *displayLabelString;
    UIButton *addHouseButton;
    UITextField *pigHouseNum;
    UILabel *firstL;
}

#pragma mark getter

- (UIScrollView *)leftScrollView {
    if (!_leftScrollView) {
        _leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 5, 50, KWindowHeight-(NaviHeight)-10)];
        _leftScrollView.delegate = self;
        [_leftScrollView setBounces:YES];
        _leftScrollView.showsVerticalScrollIndicator = NO;
        _leftScrollView.backgroundColor = [UIResource getffffffColor];
        _leftScrollView.contentSize = CGSizeMake(0, KWindowHeight);
        for (int i=0; i<self.pigHouseArr.count; i++) {
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            itemBtn.frame = CGRectMake(0, ((i%8)*50), 50, 50);
            itemBtn.tag = 100+i;
            itemBtn.selected = (i==0)?YES:NO;
            [itemBtn setBackgroundImage:[UIResource imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
            [itemBtn setBackgroundImage:[UIResource imageWithColor:[UIResource getffffffColor]] forState:UIControlStateSelected];
            [itemBtn setTitle:self.pigHouseArr[i] forState:UIControlStateNormal];
            [itemBtn setTitleColor:[UIResource getffffffColor] forState:UIControlStateNormal];
            [itemBtn setTitleColor:[UIResource get0faae2Color] forState:UIControlStateSelected];
            itemBtn.titleLabel.font = MXFont12;
            itemBtn.layer.borderWidth = 0.5f;
            itemBtn.layer.borderColor = [UIResource getffffffColor].CGColor;
            [itemBtn addTarget:self action:@selector(itemSelectTapped:) forControlEvents:UIControlEventTouchUpInside];
            [_leftScrollView addSubview:itemBtn];
        }
    }
    return _leftScrollView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(60, 5, KWindowWidth-65, KWindowHeight-(NaviHeight)-10)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.backgroundColor = [UIResource getf3f3f3Color];
        if (@available(iOS 11.0, *)) {
            _rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _rightTableView;
}

- (NSArray *)pigHouseArr {
    if (!_pigHouseArr) {
        _pigHouseArr = @[@"后备栋", @"配怀栋", @"分娩栋", @"公猪栋", @"种猪栋", @"保育栋", @"育肥栋", @"育成栋"];
    }
    return _pigHouseArr;
}

- (NSMutableArray *)addPigHouseArr {
    if (!_addPigHouseArr) {
        _addPigHouseArr = [[NSMutableArray alloc] init];
    }
    return _addPigHouseArr;
}

#pragma mark view lifeCircle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    itemString = @"1";
    [self getPigHouseData:itemString];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    headerFirstStr = @" 后备";
    headerFourthStr = @"添加后备栋";
    
    [self.view addSubview:self.leftScrollView];
    [self.view addSubview:self.rightTableView];
    
}

- (void)getBaseData:(NSString *)pigHouseKindString pigHouseKindTapped:(NSString *)pigHouseKindTapped {
    if ([self keyboardLengthLimit]) {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
        [MMProgressHUD showWithStatus:@"正在加载"];
        NSLog(@"%@%@", pigHouseKindString, pigHouseKindTapped);
        NSDictionary *paramDic = @{
                                   @"F_MerchantCode":[UserDefaults objectForKey:MERCHANTCODE],
                                   @"F_ItemId":pigHouseKindString,
                                   @"F_PigHouseName":pigHouseKindTapped
                                   };
        NSDictionary *dic = @{
                              @"Token"    :  [UserDefaults objectForKey:TOKEN],
                              @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
                              @"Data"     :  [BANetTool strDic:paramDic]
                              };
        [BANetTool postWithUrl:PGAddNewFarm params:dic success:^(id response) {
            if ([response[@"code"] isEqualToNumber:@(200)]) {
                [MMProgressHUD dismissWithSuccess:response[@"info"]];
                // 查询数据
                [self getPigHouseData:itemString];
            } else {
                [MMProgressHUD dismissWithError:response[@"info"]];
                [self.rightTableView reloadData];
            }
        } fail:^(NSError *error) {
            [MMProgressHUD dismissWithError:@"网络超时"];
        }];
    }
}

- (void)getPigHouseData:(NSString *)pigHouseKindString {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"正在加载"];
    [self.addPigHouseArr removeAllObjects];
    NSDictionary *paramDic = @{
                               @"F_MerchantCode":[UserDefaults objectForKey:MERCHANTCODE],
                               @"F_ItemId":pigHouseKindString
                               };
    NSDictionary *dic = @{
                          @"Token"    :  [UserDefaults objectForKey:TOKEN],
                          @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
                          @"Data"     :  [BANetTool strDic:paramDic]
                          };
    [BANetTool postWithUrl:PGGetPigHouses params:dic success:^(id response) {
        if ([response[@"code"] isEqualToNumber:@(200)]) {
            [MMProgressHUD dismissWithSuccess:response[@"info"]];
            NSArray *dataDic = response[@"data"];
            for (NSDictionary *subDic in dataDic) {
                BAPigHouseModel *model = [BAPigHouseModel mj_objectWithKeyValues:subDic];
                NSString *stringB = [model.F_ItemName substringWithRange:NSMakeRange(0, 2)];
                displayLabelString = [NSString stringWithFormat:@"%@%@栋", stringB, model.F_PigHouseName];
                model.F_PigAllName = displayLabelString;
                [self.addPigHouseArr addObject:model];
            }
            [self.rightTableView reloadData];
        } else {
            [MMProgressHUD dismissWithError:response[@"info"]];
        }
        
    } fail:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"网络超时"];
    }];
}

- (BOOL)keyboardLengthLimit {
    if (pigHouseNum.text.length>5) {
        [KWindow makeToast:@"编号长度过长，请输入小于5的字数"];
        return NO;
    }
    return YES;
}

- (void)addPigHouseKindTapped:(UIButton *)sender {
    [pigHouseNum endEditing:YES];
    [self getBaseData:itemString pigHouseKindTapped:pigHouseNum.text];
}

- (void)itemSelectTapped:(UIButton *)sender {
    if (sender.tag!=100) {
        UIButton *btn0 = (UIButton *)[self.view viewWithTag:100];
        btn0.selected = NO;
    }
    if (sender != self.tempBtn) {
        self.tempBtn.selected = NO;
        sender.selected = YES;
        self.tempBtn = sender;
    } else {
        self.tempBtn.selected = YES;
    }
    
    // 设置文字
    headerFirstStr = [NSString stringWithFormat:@" %@", [self.pigHouseArr[sender.tag-100] substringWithRange:NSMakeRange(0, 2)]];
    headerFourthStr = [NSString stringWithFormat:@"添加%@", self.pigHouseArr[sender.tag-100]];
    firstL.text = headerFirstStr;
    [addHouseButton setTitle:headerFourthStr forState:UIControlStateNormal];
    
    // 切换item
    buttonMarkString = (sender.tag == 107)?@"OOO":@"XXX";
    NSString *tagString = [NSString stringWithPighouseType:self.pigHouseArr[sender.tag-100]];
    itemString = [NSString stringWithFormat:@"%ld", tagString.integerValue];
    [self getPigHouseData:itemString];
    
}

- (void)deleteTapped:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"正在加载"];
    // 获取text
//    NSIndexPath *indexPath = [self.rightTableView indexPathForSelectedRow];
//    UITableViewCell *cell = [self.rightTableView cellForRowAtIndexPath:sender.tag-10];
    CGPoint point = sender.center;
    point = [self.self.rightTableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.self.rightTableView indexPathForRowAtPoint:point];
    UITableViewCell *cell = [self.rightTableView cellForRowAtIndexPath:indexpath];
    NSDictionary *paramDic = @{
                               @"F_MerchantCode":[UserDefaults objectForKey:MERCHANTCODE],
                               @"F_ItemId":itemString,
                               @"F_PigHouseName":cell.textLabel.text
                               };
    NSDictionary *dic = @{
                          @"Token"    :  [UserDefaults objectForKey:TOKEN],
                          @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
                          @"Data"     :  [BANetTool strDic:paramDic]
                          };
    [BANetTool postWithUrl:PGDeletePigFarm params:dic success:^(id response) {
        if ([response[@"code"] isEqualToNumber:@(200)]) {
            [MMProgressHUD dismissWithSuccess:response[@"info"]];
            // 查询数据
            [self getPigHouseData:itemString];
        } else {
            [MMProgressHUD dismissWithError:response[@"info"]];
            [self.rightTableView reloadData];
        }
    } fail:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"网络超时"];
    }];
    
}

#pragma mark tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addPigHouseArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 添加分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, 44, tableView.width-5, 0.5f)];
    line.backgroundColor = [UIResource getf3f3f3Color];
    [cell addSubview:line];
    
    // 添加删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(tableView.width-50, 7, 40, 30);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = MXFont12;
    deleteBtn.layer.cornerRadius = 5;
    [deleteBtn setBackgroundColor:[UIColor redColor]];
    deleteBtn.tag = 10+indexPath.row;
    [deleteBtn setTitleColor:[UIResource getffffffColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:deleteBtn];
    
    BAPigHouseModel *model = self.addPigHouseArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", model.F_PigAllName];

    return cell;
}

#pragma mark set footer

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    headerView.backgroundColor = [UIResource getffffffColor];
    if ([buttonMarkString isEqualToString:@"OOO"]) {
        headerView.hidden = YES;
    } else {
        //
        headerView.hidden = NO;
        firstL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 36)];
        firstL.text = headerFirstStr;
        firstL.font = MXFont12;
        [headerView addSubview:firstL];
        
        pigHouseNum = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstL.frame)+4, 5.5, 120, 25)];
        pigHouseNum.delegate = self;
        pigHouseNum.placeholder = @"编号";
        pigHouseNum.layer.cornerRadius = 5;
        pigHouseNum.layer.borderWidth = 0.5f;
        pigHouseNum.layer.borderColor = [UIResource geta6a2a3Color].CGColor;
        pigHouseNum.font = MXFont12;
        [headerView addSubview:pigHouseNum];
        
        UILabel *dongL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pigHouseNum.frame)+4, 0, 25, 36)];
        dongL.text = @"栋";
        dongL.textAlignment = NSTextAlignmentCenter;
        dongL.font = MXFont12;
        [headerView addSubview:dongL];
        
        //
        addHouseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addHouseButton.frame = CGRectMake(CGRectGetMaxX(dongL.frame)+4, 5.5, tableView.width-dongL.width-pigHouseNum.width-firstL.width-20, 25);
        [addHouseButton setTitle:headerFourthStr forState:UIControlStateNormal];
        addHouseButton.titleLabel.font = MXFont12;
        addHouseButton.layer.cornerRadius = 5;
        [addHouseButton setBackgroundColor:[UIResource get0faae2Color]];
        [addHouseButton setTitleColor:[UIResource getffffffColor] forState:UIControlStateNormal];
        [addHouseButton addTarget:self action:@selector(addPigHouseKindTapped:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:addHouseButton];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 36, tableView.width, 4)];
        line.backgroundColor = [UIResource getf3f3f3Color];
        [headerView addSubview:line];
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [buttonMarkString isEqualToString:@"OOO"]?0.f:40.f;
}

#pragma mark keyboard delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

@end
