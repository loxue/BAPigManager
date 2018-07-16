//
//  BACreatePigFarmController.m
//  PigManager
//
//  Created by imac on 2018/7/4.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BACreatePigFarmController.h"

@interface BACreatePigFarmController ()<UITextFieldDelegate>

@end

@implementation BACreatePigFarmController
{
    UITextField *textInput;
    NSString *nameTextString, *areaTextString, *detailAddressTextString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"建立猪场账户";
    self.view.backgroundColor = [UIResource getf3f3f3Color];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, KWindowWidth-10, 220)];
    backView.backgroundColor = [UIResource getffffffColor];
    [self.view addSubview:backView];
    
    NSArray *titleArr = @[@"猪场名称  *", @"所在地区  *", @"详细地址  *"];
    for (int i=0; i<titleArr.count; i++) {
        // 文本显示
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 18+(i)*50, 90, 20)];
        titleLabel.font = MXFont14;
        titleLabel.textColor = [UIResource get3e3e3eColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = titleArr[i];
        // 创建attributed
        NSString *atts = titleArr[i];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:atts];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(atts.length-1, 1)];
        titleLabel.attributedText = attributedStr;
        [backView addSubview:titleLabel];
        
        // 文本输入框
        textInput = [[UITextField alloc] initWithFrame:CGRectMake(95, 10+(i)*50, backView.width-CGRectGetWidth(titleLabel.frame)-5*2-5, 35)];
        textInput.tag = i;
        textInput.layer.cornerRadius = 5;
        textInput.layer.borderWidth = 0.5f;
        textInput.layer.borderColor = [UIResource geta6a2a3Color].CGColor;
        textInput.font = MXFont14;
        textInput.delegate = self;
        textInput.placeholder = @" 请输入";
        [backView addSubview:textInput];
    }
    
    // 确认提交
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(5, 170, backView.width-10, 40);
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIResource getffffffColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIResource get0faae2Color]];
    submitBtn.titleLabel.font = MXFont14;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.tag = 3;
    [submitBtn addTarget:self action:@selector(submitTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:submitBtn];
    
}

- (void)submitTapped:(UIButton *)sender {
    /*
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"正在加载"];
    NSDictionary *paramDic = @{
                               @"F_ItemId":@"3",
                               @"F_MerchantCode":[UserDefaults objectForKey:MERCHANTCODE],
                               @"F_PigHouseName":@"分娩4栋"
                               };
    NSDictionary *dic = @{
                          @"Token":@"",
                          @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
                          @"Data"     :  [BANetTool strDic:paramDic]
                          };
    [BANetTool postWithUrl:PGLogin params:dic success:^(id response) {
        if ([response[@"code"] isEqualToNumber:@(200)]) {
            [MMProgressHUD dismissWithSuccess:response[@"info"]];
            NSDictionary *dataDic = response[@"data"];
            
        } else {
            [MMProgressHUD dismissWithError:response[@"info"]];
        }
    } fail:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"网络超时"];
    }];
     */
}

// text delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    switch (textField.tag) {
        case 0:
            {
                nameTextString = textField.text;
            }
            break;
        case 1:
            {
                areaTextString = textField.text;
            }
            break;
        case 2:
            {
                detailAddressTextString = textField.text;
            }
            break;

        default:
            break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textInput endEditing:YES];
}

@end
