//
//  BABaseViewController.m
//  365
//  马彦春
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
    [BANetTool postWithUrl:BABaseNetAddress params:param success:^(id response) {
        if ([response[@"code"] isEqualToNumber:@(9003)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"homeRefresh" object:nil];
            });
            [self.navigationController popToRootViewControllerAnimated:NO];
            CYLTabBarController *controller = [self cyl_tabBarController];
            [controller setSelectedIndex:0];
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
