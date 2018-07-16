//
//  BAStartGuideViewController.m
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAStartGuideViewController.h"
#import "BANavigationController.h"
#import "BALoginController.h"

@interface BAStartGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation BAStartGuideViewController
{
    UIImageView *imageV;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIResource getf3f3f3Color];
    [self.view addSubview:_scrollView];

    NSArray *imgArr = @[@"start_0", @"start_1", @"start_2", @"start_3"];
    for (int i = 0; i< imgArr.count; i++) {
        NSString *image = [imgArr objectAtIndex:i];
        UIImage *imageSrc = [self imageNamed:image];
        imageV = [[UIImageView alloc] initWithImage:imageSrc];
        imageV.frame = CGRectMake(KWindowWidth*i, 0, KWindowWidth, KWindowHeight);
        imageV.contentMode = UIViewContentModeScaleToFill;
        [_scrollView addSubview:imageV];
        if (i == imgArr.count-1) {
            imageV.userInteractionEnabled = YES;

            UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((KWindowWidth-180)/2, KWindowHeight-44-55, 180, 44)];
            loginBtn.layer.cornerRadius = 22;
            loginBtn.backgroundColor = [UIResource get0faae2Color];
            [loginBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            [loginBtn setTitleColor:[UIResource getffffffColor] forState:UIControlStateNormal];
            loginBtn.titleLabel.font = MXFont16;
            [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [imageV addSubview:loginBtn];
        }
    }
    _scrollView.contentSize = CGSizeMake(KWindowWidth * imgArr.count, 0);
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
}

- (UIImage *)imageNamed:(NSString *)name {
    NSString *suffix_str = nil;

    if (iPhone6) {
        suffix_str = @"-667h@2x";
    } else if (iPhone6p) {
        suffix_str = @"-736h@2x";
    } else if (iPhoneX) {
        suffix_str = @"-960h@2x";
    } else {
        suffix_str = @"-667h@2x";
    }

    if (suffix_str) {
        NSString *checkName = [NSString stringWithFormat:@"%@%@", name, suffix_str];
        NSString *checkPath = [[NSBundle mainBundle]  pathForResource:checkName ofType:@"png"];
        if (checkPath) {
            return [UIImage imageWithContentsOfFile:checkPath];
        } else {
            checkPath = [[NSBundle mainBundle]  pathForResource:checkName ofType:@"jpg"];
            if (checkPath) {
                return [UIImage imageWithContentsOfFile:checkPath];
            }
        }
    }

    name = [NSString stringWithFormat:@"%@@2x", name];
    UIImage *img = [UIImage imageNamed:name];
    return img;
}

- (void)loginBtnClicked {
    BALoginController *loginVC = [[BALoginController alloc] init];
    loginVC.vcindex = @"1";
    UIViewController *rootVC = [[BANavigationController alloc] initWithRootViewController:loginVC];
    KWindow.rootViewController = rootVC;
}

- (NSString *)getFilePathWithImageName:(NSString *)imageName {
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    return nil;
}

@end
