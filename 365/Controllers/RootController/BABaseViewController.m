//
//  BABaseViewController.m
//  365
//
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BABaseViewController.h"

@interface BABaseViewController ()

@end

@implementation BABaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;//IOS7下Statusbar出现透明及界面下方出现空白 设置使其正常
    self.view.backgroundColor = [UIResource getf3f3f3Color];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *ukey = [NSString stringWithFormat:@"%@", [UserDefaults objectForKey:@"UKEY"]];
    NSString *uid = [UIResource getUid];
    if ([ukey isEqualToString:@"(null)"]) {
        ukey = @"";
    }
    NSDictionary *param = @{@"ukey":ukey,
                            @"uid":uid,
                            @"os_type":@"2",
                            @"imei":@"userId"};
    [BARequestManager postRequestWithURL:BABaseNetAddress parameters:param success:^(id response) {
        if ([response[@"code"] isEqualToNumber:@(9002)]) {
            //弹窗
            //            MXTipsWarnView *view = [[MXTipsWarnView alloc] initWithImage:@"alert_tips" Title:@"该账号已在其它手机登录" message:@"如非本人操作，请尽快修改密码" sureBtnTitle:@"确定" cancleBtnTitle:@"" isHidden:YES];
            //            [view show];
            //            [view setClickBlock:^(int index) {
            //                NSDictionary *param = @{@"uid":[UIResource getUid]};
            //                [PPHTTPRequest postJinFuRequestWithURL:LOGOUT parameters:param success:^(id response) {
            //                    [UIResource removeUserDefaults];
            //                    [self.navigationController popToRootViewControllerAnimated:NO];
            //                    CYLTabBarController *controller = [self cyl_tabBarController];
            //                    [controller setSelectedIndex:0];
            //                    dispatch_async(dispatch_get_main_queue(), ^{
            //                        [[NSNotificationCenter defaultCenter] postNotificationName:@"homeRefresh" object:nil];
            //                    });
            //                } failure:^(NSError *error) {
            //
            //                }];
            //            }];
        } else if ([response[@"code"] isEqualToNumber:@(9003)]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"homeRefresh" object:nil];
            });
            [self.navigationController popToRootViewControllerAnimated:NO];
            CYLTabBarController *controller = [self cyl_tabBarController];
            [controller setSelectedIndex:0];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
