//
//  BAPArameterSettingController.m
//  PigManager
//  马彦春
//  Created by imac on 2018/6/12.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAPArameterSettingController.h"

@interface BAPArameterSettingController ()

@end

@implementation BAPArameterSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i=0; i<4; i++) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSArray *imgArr = @[@"muzhucanshushezhi", @"shedingshengchanmubiao", @"shedingyichangbaojing", @"shedingzhongzhutaotaibiaozhun"];
        NSArray *titleArr = @[@"母猪参数设置", @"设定种猪淘汰标准", @"设定异常报警", @"设定生产时间"];
        itemBtn.frame = CGRectMake((5+(i%2)*(KWindowWidth/2)), (5+(i/2)*(KWindowWidth/2)), (KWindowWidth/2)-10, (KWindowWidth/2)-10);
        [itemBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [itemBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        itemBtn.tag = i;
        [itemBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        itemBtn.titleLabel.font = MXFont12;
        [itemBtn setBackgroundColor:[UIResource getffffffColor]];
        itemBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        itemBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 40, 40, 40);
        itemBtn.titleEdgeInsets = UIEdgeInsetsMake(60, -50, 0, 20);
        [itemBtn addTarget:self action:@selector(itemSelectTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:itemBtn];
    }

}

- (void)itemSelectTapped:(UIButton *)sender {
    
}

@end
