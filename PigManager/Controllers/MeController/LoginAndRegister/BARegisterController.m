//
//  BARegisterController.m
//  PigManager
//  马彦春
//  Created by imac on 2018/6/11.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BARegisterController.h"
#import "NSString+DNUStringExt.h"
#import "BAWebViewController.h"

@interface BARegisterController()<UITextFieldDelegate>

@end

@implementation BARegisterController
{
    int time;
    NSTimer *reGetTimer;
    UITextField *phoneNumberText, *passwordText, *codeText, *investCodeText;
    UIButton *registBtn, *codeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    UIButton *back = [UIResource getBackBtnWithImage:@"tab_back"];
    [back addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 50)];
    backView1.backgroundColor = [UIResource getffffffColor];
    [self.view addSubview:backView1];
    
    phoneNumberText = [UIResource getTextFielfWithFrame:CGRectMake(15, 0, KWindowWidth-15, 50) placeholder:@"请输入手机号" leftImg:@"personal_login_phone"];
    phoneNumberText.delegate = self;
    phoneNumberText.keyboardType = UIKeyboardTypePhonePad;
    [backView1 addSubview:phoneNumberText];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneNumberText.frame), KWindowWidth-15, 0.5)];
    line.backgroundColor = [UIResource geteeeeeeColor];
    [backView1 addSubview:line];
    
    passwordText = [UIResource getTextFielfWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame), KWindowWidth-15, 50) placeholder:@"请输入密码" leftImg:@"personal_login_password"];
    passwordText.delegate = self;
    [passwordText setSecureTextEntry:YES];
    [backView1 addSubview:passwordText];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(passwordText.frame), KWindowWidth-15, 0.5)];
    line1.backgroundColor = [UIResource geteeeeeeColor];
    [backView1 addSubview:line1];
    investCodeText = [UIResource getTextFielfWithFrame:CGRectMake(15, CGRectGetMaxY(line1.frame), KWindowWidth-30, 50) placeholder:@"请确认密码" leftImg:@"personal_invest"];
    investCodeText.delegate = self;
    [investCodeText setSecureTextEntry:YES];
    [backView1 addSubview:investCodeText];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(investCodeText.frame), KWindowWidth-15, 0.5)];
    line2.backgroundColor = [UIResource geteeeeeeColor];
    [backView1 addSubview:line2];
    
    codeText = [UIResource getTextFielfWithFrame:CGRectMake(15, CGRectGetMaxY(line2.frame), KWindowWidth-15-80, 50) placeholder:@"请输入验证码" leftImg:@"personal_regist_code"];
    codeText.delegate = self;
    codeText.keyboardType = UIKeyboardTypePhonePad;
    [backView1 addSubview:codeText];
    
    codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth-80, CGRectGetMaxY(line2.frame), 80, 50)];
    [codeBtn setTitle:@"点击获取" forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIResource get0faae2Color] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = MXFont15;
    [codeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [backView1 addSubview:codeBtn];
    
    backView1.height = CGRectGetMaxY(codeText.frame);
    
    registBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backView1.frame)+28, KWindowWidth-30, 44)];
    registBtn.layer.cornerRadius = 5;
    registBtn.backgroundColor = [UIResource get0faae2Color];
    [registBtn setTitleColor:[UIResource getffffffColor] forState:UIControlStateNormal];
    [registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font = MXFont18;
    [registBtn addTarget:self action:@selector(registBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    UILabel *protocolLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(registBtn.frame)+14, KWindowWidth, 15)];
    protocolLabel.attributedText = [UIResource changeLabelWithText:@"注册即同意《用户注册协议》" andLength:5 andFirstFont:MXFont13 andLastFont:MXFont13 andFirstColor:[UIResource get0faae2Color] andLastColor:[UIResource get0faae2Color]];
    protocolLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolLabelClicked)];
    protocolLabel.userInteractionEnabled = YES;
    [protocolLabel addGestureRecognizer:tapRecognizer];
    [self.view addSubview:protocolLabel];
}

- (void)getCode {
    [self.view endEditing:YES];
    if (phoneNumberText.text.length != 11) {
        [KWindow makeToast:@"请输入正确的手机号"];
    } else {
        time = 60;
        if (!reGetTimer) {
            reGetTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(codeCountDown) userInfo:nil repeats:YES];
            [reGetTimer fire];
        } else {
            [reGetTimer setFireDate:[NSDate date]];
        }
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
        [MMProgressHUD showWithStatus:@""];
        NSString *sign = [[NSString stringWithFormat:@"sendApp%@XGJF--2017JFXGF.J.G.X", phoneNumberText.text] stringFromMD5];
        NSDictionary *param = @{@"tel":phoneNumberText.text,
                                @"os_type":@"2",
                                @"tel_type":@"1",
                                @"sign":sign};
        [BANetTool postWithUrl:PGRegister params:param success:^(id response) {
            if ([response[@"code"] isEqualToNumber:@(1000)]) {
                [MMProgressHUD dismissWithSuccess:@"验证码已下发至您的手机"];
            } else {
                [MMProgressHUD dismissWithError:response[@"message"]];
            }
        } fail:^(NSError *error) {
            [MMProgressHUD dismissWithError:@"网络超时"];
        }];
    }
}

- (void)codeCountDown {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (time == 0) {
            codeBtn.enabled = YES;
            [codeBtn setTitle:@"点击获取" forState:UIControlStateNormal];
            [codeBtn setTitleColor:[UIResource get0faae2Color] forState:UIControlStateNormal];
            [reGetTimer setFireDate:[NSDate distantFuture]];
            return;
        } else {
            codeBtn.enabled = NO;
            NSString *title = [NSString stringWithFormat:@"%i s", time];
            [codeBtn setTitleColor:[UIResource get666566Color] forState:UIControlStateNormal];
            [codeBtn setTitle:title forState:UIControlStateNormal];
        }
        time--;
    });
}

- (void)registBtnClicked {
    if ([self inputIsValid]) {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
        [MMProgressHUD showWithStatus:@"正在注册"];
        NSDictionary *testDic = @{
                                  @"F_Mobile" : phoneNumberText.text,
                                  @"F_Password": [passwordText.text stringFromMD5]
                                 };
        NSDictionary *dic = @{
                              @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
                              @"Data"     : [BANetTool strDic:testDic]
                              };
        [BANetTool postWithUrl:PGRegister params:dic success:^(id response) {
            if ([response[@"code"] isEqualToNumber:@(200)]) {
                NSLog(@"------%@----", response[@"code"]);
                [MMProgressHUD dismissWithSuccess:response[@"info"]];
                [UserDefaults setObject:phoneNumberText.text forKey:PHOTONUM];
                [UserDefaults setBool:YES forKey:ISLOGIN];
                [UserDefaults synchronize];
                
//                if ([[UserDefaults objectForKey:ISLOGIN] isEqualToString:@"1"]) { //注册完去登录，还是登录免登录
                    [self.navigationController popToRootViewControllerAnimated:YES];
//                } else {
//                    BATabBarControllerConfig *tabBarControllerConfig = [[BATabBarControllerConfig alloc] init];
//                    tabBarControllerConfig.tabBarController.delegate = KAppDelegate;
//                    KWindow.rootViewController = tabBarControllerConfig.tabBarController;
//                }
            } else {
                [MMProgressHUD dismissWithError:response[@"info"]];
            }
        } fail:^(NSError *error) {
            [MMProgressHUD dismissWithError:@"网络超时"];
        }];
    }
}

- (void)protocolLabelClicked {
    NSString *url = [NSString stringWithFormat:@"%@", @"ddd"];
    BAWebViewController *vc = [[BAWebViewController alloc] init];
    vc.titleStr = @"注册协议";
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)inputIsValid {
    if (phoneNumberText.text.length < 1 ) {
        [KWindow makeToast:@"请输入手机号"];
        return NO;
    }
    if (passwordText.text.length < 6 ) {
        [KWindow makeToast:@"密码长度不足6位"];
        return NO;
    }
    if ([passwordText.text isAllNumber]) {
        [KWindow makeToast:@"请组合设置"];
        return NO;
    }
    if ([passwordText.text isAllLetters]) {
        [KWindow makeToast:@"请组合设置"];
        return NO;
    }
    if ([passwordText.text isAllCharacterString]) {
        [KWindow makeToast:@"请组合设置"];
        return NO;
    }
    if (![passwordText.text isEqualToString:investCodeText.text]) {
        [KWindow makeToast:@"两次密码输入不一致"];
        return NO;
    }
//    if (codeText.text.length < 1 ) {
//        [KWindow makeToast:@"请输入验证码"];
//        return NO;
//    }
    return YES;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == passwordText) {
        if ([string length] == 0) {
            return YES;
        }
        if ([textField.text length] > 16)
            return NO;
        NSMutableString *fieldText=[NSMutableString stringWithString:textField.text];
        [fieldText replaceCharactersInRange:range withString:string];
        NSString *finalText=[fieldText copy];
        if ([finalText length] > 16) {
            textField.text=[finalText substringToIndex:16];
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
