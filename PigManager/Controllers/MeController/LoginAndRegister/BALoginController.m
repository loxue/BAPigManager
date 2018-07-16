//
//  BALoginController.m
//  365
//  马彦春
//  Created by imac on 2018/5/29.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BALoginController.h"
#import "BARegisterController.h"
#import "BAForgetPasswordController.h"

@interface BALoginController ()<UITextFieldDelegate>

@end

@implementation BALoginController {
    UITextField *phoneNumberText, *passwordText;
    UIButton *loginBtn, *forgetBtn , *back, *registBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"登录";
    
    if (self.presentingViewController) {
        back = [[UIButton alloc] initWithFrame:CGRectMake(6, 0, 40, 44)];
        [back setImage:[UIImage imageNamed:@"tab_back"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:back];
    }
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bj"]];
    bgImg.frame = CGRectMake(0, 0, KWindowWidth, 212);
    [self.view addSubview:bgImg];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(bgImg.frame)+45, KWindowWidth-30, 50)];
    [self.view addSubview:backView];
    
    
    UIImageView *phoneImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phoneImg"]];
    phoneImg.frame = CGRectMake(50, 16, 18, 18);
    [backView addSubview:phoneImg];
    phoneNumberText = [UIResource getTextFielfWithFrame:CGRectMake(CGRectGetMaxX(phoneImg.frame), 0, KWindowWidth-100, 50) placeholder:@"请输入用户名或手机号" leftImg:@"personal_login_phone"];
    phoneNumberText.delegate = self;
    phoneNumberText.keyboardType = UIKeyboardTypeDefault;
    [backView addSubview:phoneNumberText];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(45, CGRectGetMaxY(phoneNumberText.frame), KWindowWidth-90, 0.5)];
    line.backgroundColor = [UIResource geteeeeeeColor];
    [backView addSubview:line];
    
    UIImageView *sImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sImg"]];
    sImg.frame = CGRectMake(50, CGRectGetMaxY(line.frame)+16, 18, 18);
    [backView addSubview:sImg];
    passwordText = [UIResource getTextFielfWithFrame:CGRectMake(CGRectGetMaxX(sImg.frame), CGRectGetMaxY(line.frame), KWindowWidth-100, 50) placeholder:@"请输入密码" leftImg:@"personal_login_password"];
    passwordText.delegate = self;
    [passwordText setSecureTextEntry:YES];
    [backView addSubview:passwordText];
    
    backView.height = CGRectGetMaxY(passwordText.frame);
    
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(backView.frame)+28, KWindowWidth-100, 44)];
    loginBtn.layer.cornerRadius = 20;
    [loginBtn setImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(loginBtn.frame)+26, 60, 15)];
    [forgetBtn setTitleColor:[UIResource get0faae2Color] forState:UIControlStateNormal];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = MXFont13;
    [forgetBtn addTarget:self action:@selector(forgetBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    registBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth-110, CGRectGetMaxY(loginBtn.frame)+26, 60, 15)];
    [registBtn setTitleColor:[UIResource get0faae2Color] forState:UIControlStateNormal];
    [registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font = MXFont13;
    [registBtn addTarget:self action:@selector(registClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    back.hidden = NO;
    self.navigationController.navigationBarHidden = ([self.vcindex isEqualToString:@"1"] || [self.vcindex isEqualToString:@"2"])?YES:NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    back.hidden = YES;
}

- (void)loginBtnClicked {
    if ([self inputIsValid]) {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
        [MMProgressHUD showWithStatus:@"正在登录"];
        NSDictionary *paramDic = @{
                                  @"F_Mobile" : phoneNumberText.text,
                                  @"F_Password": [passwordText.text stringFromMD5]
                                  };
        NSDictionary *dic = @{
                              @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
                              @"Data"     : [BANetTool strDic:paramDic]
                              };
        [BANetTool postWithUrl:PGLogin params:dic success:^(id response) {
            if ([response[@"code"] isEqualToNumber:@(200)]) {
                [MMProgressHUD dismissWithSuccess:response[@"info"]];
                NSDictionary *dataDic = response[@"data"];
                [UserDefaults setObject:[dataDic objectForKey:@"Token"] forKey:TOKEN];
                [UserDefaults setObject:[dataDic objectForKey:@"MerchantCode"] forKey:MERCHANTCODE];
                [UserDefaults setObject:[dataDic objectForKey:@"IsAdmin"] forKey:ISADMIN];
                [UserDefaults setObject:[dataDic objectForKey:@"PostIds"] forKey:POSTIDS];
                [UserDefaults setBool:YES forKey:ISLOGIN];
                [UserDefaults synchronize];
                BATabBarControllerConfig *tabBarControllerConfig = [[BATabBarControllerConfig alloc] init];
                tabBarControllerConfig.tabBarController.delegate = KAppDelegate;
                KWindow.rootViewController = tabBarControllerConfig.tabBarController;
            } else {
                [MMProgressHUD dismissWithError:response[@"info"]];
            }
        } fail:^(NSError *error) {
            [MMProgressHUD dismissWithError:@"网络超时"];
        }];
    }
}

- (void)forgetBtnClicked {
    self.navigationController.navigationBarHidden = NO;
    BAForgetPasswordController *vc = [[BAForgetPasswordController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registClicked {
    self.navigationController.navigationBarHidden = NO;
    BARegisterController *vc = [[BARegisterController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)inputIsValid {
    if (phoneNumberText.text.length < 1 ) {
        [KWindow makeToast:@"请输入手机号"];
        return NO;
    }
    if (passwordText.text.length < 1 ) {
        [KWindow makeToast:@"请输入密码"];
        return NO;
    }
    return YES;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
