//
//  BAAddBreedingPigController.m
//  PigManager
//
//  Created by imac on 2018/7/5.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAAddBreedingPigController.h"
#import "BAPickerView.h"

@interface BAAddBreedingPigController ()<UITextFieldDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation BAAddBreedingPigController
{
    UITextField *textInput;
    NSString *sexTextString, *kindTextString, *earTagTextString, *categoryTextString, *gestationalageTextString, *dongsheTextString, *fieldTextString, *birthTextString, *sourceTextString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 5, KWindowWidth-10, KWindowHeight-(NaviHeight)-10)];
    self.scrollView.delegate = self;
    [self.scrollView setBounces:YES];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIResource getffffffColor];
    self.scrollView.contentSize = CGSizeMake(0, KWindowHeight);
    [self.view addSubview:self.scrollView];

    self.view.backgroundColor = [UIResource getf3f3f3Color];
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height)];
    bigView.backgroundColor = [UIResource getffffffColor];
    [self.scrollView addSubview:bigView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bigView.width, 40)];
    tipLabel.text = @"原始档案信息";
    tipLabel.font = MXFont12;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIResource get3e3e3eColor];
    [bigView addSubview:tipLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40.5, bigView.width, 0.5)];
    line.backgroundColor = [UIResource geta6a2a3Color];
    [bigView addSubview:line];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(5, 41, bigView.width-10, bigView.height-CGRectGetMaxY(line.frame)-10)];
    backView.backgroundColor = [UIResource getffffffColor];
    [bigView addSubview:backView];
    NSArray *titleArr = @[@"性别            *", @"品种            *", @"耳标            *",  @"类别            *", @"胎龄            *", @"栋舍    ", @"栏位    ", @"出生年月    *", @"来源    "];
    for (int i=0; i<titleArr.count; i++) {
        // 文本显示
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 18+(i)*45, 90, 20)];
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
        textInput = [[UITextField alloc] initWithFrame:CGRectMake(95, 10+(i)*45, backView.width-CGRectGetWidth(titleLabel.frame)-5*2-5, 30)];
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
    submitBtn.frame = CGRectMake(10, KWindowHeight-(NaviHeight)-110, backView.width-20, 40);
    [submitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIResource getffffffColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIResource get0faae2Color]];
    submitBtn.titleLabel.font = MXFont14;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.tag = 3;
    [submitBtn addTarget:self action:@selector(saveTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:submitBtn];
    
}

- (void)saveTapped:(UIButton *)sender {
    if ([self inputVerification]) {
         [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
         [MMProgressHUD showWithStatus:@"正在加载"];
         NSDictionary *paramDic = @{
             @"F_MerchantCode":[UserDefaults objectForKey:MERCHANTCODE],
             @"F_PigType":sexTextString,
             @"F_PigVariety":kindTextString,
             @"F_EarTag":earTagTextString,
             @"F_PigCategory":categoryTextString,
             @"F_PigHouseId":gestationalageTextString,
             @"F_PigHouseName":dongsheTextString,
             @"F_Field":fieldTextString,
             @"F_PigBirthday":birthTextString,
             @"F_PigOrigin":sourceTextString
         };
         NSDictionary *dic = @{
             @"Token"    :  [UserDefaults objectForKey:TOKEN],
             @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
             @"Data"     :  [BANetTool strDic:paramDic]
         };
         [BANetTool postWithUrl:PGAddNewPig params:dic success:^(id response) {
             if ([response[@"code"] isEqualToNumber:@(200)]) {
                 [MMProgressHUD dismissWithSuccess:response[@"info"]];
                 NSDictionary *dataDic = response[@"data"];
             
             } else {
                 [MMProgressHUD dismissWithError:response[@"info"]];
             }
         } fail:^(NSError *error) {
             [MMProgressHUD dismissWithError:@"网络超时"];
         }];
    }
}

// text delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    WeakSelf(self);
    switch (textField.tag) {
        case 0:
        {
            // 性别
            [textField resignFirstResponder];

            NSString *defaultSelValue = [[BAPickerView showStringPickerDataSourceStyle:BAStringPickerViewStyleGender] objectAtIndex:0];
            [BAPickerView showStringPickerWithTitle:@"猪的性别"
                                    DefaultSelValue:defaultSelValue
                                       IsAutoSelect:YES
                                            Manager:nil
                                        ResultBlock:^(id selectValue, id selectRow)
                                                    {
                                                        sexTextString = selectValue;
                                                        textField.text = sexTextString;
                                                    }
                                              Style:BAStringPickerViewStyleGender];
            
        }
            break;
        case 1:
        {
            // 品种
            [textField resignFirstResponder];
          
            NSString *defaultSelValue = [[BAPickerView showStringPickerDataSourceStyle:BAStringPickerViewStylePigKind] objectAtIndex:0];
            [BAPickerView showStringPickerWithTitle:@"猪的品种"
                                    DefaultSelValue:defaultSelValue
                                       IsAutoSelect:YES
                                            Manager:nil
                                        ResultBlock:^(id selectValue, id selectRow)
                                                    {
                                                        kindTextString = selectValue;
                                                        textField.text = kindTextString;
                                                    }
                                              Style:BAStringPickerViewStylePigKind];
        }
            break;
        case 2:
        {
            // 耳标
            [textField becomeFirstResponder];
            earTagTextString = textField.text;
        }
            break;
        case 3:
        {
            // 类别
            [textField resignFirstResponder];
        
            NSString *defaultSelValue = [[BAPickerView showStringPickerDataSourceStyle:BAStringPickerViewStylePigGroup] objectAtIndex:0];
            [BAPickerView showStringPickerWithTitle:@"猪的类别"
                                    DefaultSelValue:defaultSelValue
                                       IsAutoSelect:YES
                                            Manager:nil
                                        ResultBlock:^(id selectValue, id selectRow)
                                                    {
                                                        categoryTextString = selectValue;
                                                        textField.text = categoryTextString;
                                                    }
                                              Style:BAStringPickerViewStylePigGroup];
        }
            break;
        case 4:
        {
            // 胎龄
            [textField becomeFirstResponder];
            gestationalageTextString = textField.text;
        }
            break;
        case 5:
        {
            [textField becomeFirstResponder];
            
            // 获取栋舍
            [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
            [MMProgressHUD showWithStatus:@"正在加载"];
            NSDictionary *paramDic = @{
                                       @"F_MerchantCode":[UserDefaults objectForKey:MERCHANTCODE],
                                       @"F_ItemId":sexTextString
                                       };
            NSDictionary *dic = @{
                                  @"Token"    :  [UserDefaults objectForKey:TOKEN],
                                  @"LoginMark":  [UserDefaults objectForKey:UUIDSTRING],
                                  @"Data"     :  [BANetTool strDic:paramDic]
                                  };
            [BANetTool postWithUrl:PGGetPigTypeHouses params:dic success:^(id response) {
                if ([response[@"code"] isEqualToNumber:@(200)]) {
                    [MMProgressHUD dismissWithSuccess:response[@"info"]];
                    NSDictionary *dataDic = response[@"data"];
                    
                } else {
                    [MMProgressHUD dismissWithError:response[@"info"]];
                }
            } fail:^(NSError *error) {
                [MMProgressHUD dismissWithError:@"网络超时"];
            }];
            
            
            
            
            
            
            
            
            dongsheTextString = textField.text;
        }
            break;
        case 6:
        {
            //栏位
            [textField becomeFirstResponder];
            fieldTextString = textField.text;
        }
            break;
        case 7:
        {
            // 出生日期
            [textField resignFirstResponder];
        
            NSDate *now = [NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *nowStr = [fmt stringFromDate:now];
    
            [BAPickerView showDatePickerWithTitle:@"猪的出生年月" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
                NSLog(@"%@",selectValue);
                birthTextString = selectValue;
                textField.text = birthTextString;
            }];
        }
            break;
        case 8:
        {
            // 来源
            [textField becomeFirstResponder];
            sourceTextString = textField.text;
        }
            break;
            
        default:
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textInput endEditing:YES];
}

- (BOOL)inputVerification {
    if (!sexTextString) {
        [KWindow makeToast:@"请输入性别"];
        return NO;
    } else if (!kindTextString) {
        [KWindow makeToast:@"请输入品种"];
        return NO;
    } else if (!earTagTextString) {
        [KWindow makeToast:@"请输入耳标"];
        return NO;
    } else if (!categoryTextString) {
        [KWindow makeToast:@"请输入类别"];
        return NO;
    } else if (!gestationalageTextString) {
        [KWindow makeToast:@"请输入胎龄"];
        return NO;
    } else if (!birthTextString) {
        [KWindow makeToast:@"请输入出生日期"];
        return NO;
    }
    
    return YES;
}

- (void)loadCustomPick {
//    WeakSelf(self);
//    if ([title isEqualToString:@"时间选择器"]){
//        [BAPickerView showDatePickerWithTitle:@"出生时刻" DateType:UIDatePickerModeTime DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
//            NSLog(@"%@",selectValue);
//            weakSelf.navigationItem.title = selectValue;;
//        }];
//    } else if ([title isEqualToString:@"日期和时间"]){
//        [BAPickerView showDatePickerWithTitle:@"日期和时间" DateType:UIDatePickerModeDateAndTime DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
//            NSLog(@"%@",selectValue);
//            weakSelf.navigationItem.title = selectValue;;
//        }];
//    } else if ([title isEqualToString:@"省,市,县"]){
//        [BAPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@4, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
//            NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
//            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];;;;
//        }];
//    } else if ([title isEqualToString:@"自定义一行"]){
//        [BAPickerView showStringPickerWithTitle:@"红豆" DataSource:@[@"很好的", @"干干", @"高度", @"打的", @"都怪怪的", @"博对"] DefaultSelValue:@"高度" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
//            NSLog(@"%@",selectValue);
//            weakSelf.navigationItem.title = selectValue;; ;
//        }];
//    }

}

@end
