//
//  BANavigationController.m
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BANavigationController.h"

@interface BANavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BANavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */

+ (void)initialize {
    // 当导航栏用在NavigationController中, appearance设置才会生效
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarStyle:UIBarStyleDefault];
    bar.translucent = NO;
    bar.barTintColor = [UIResource getffffffColor];//导航条颜色
    [bar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIResource get0faae2Color],NSForegroundColorAttributeName,MXFont17,NSFontAttributeName,nil]];//导航条标题颜色大小
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.delegate = self;
    [self setNeedsStatusBarAppearanceUpdate];

}
#pragma mark 添加右滑手势
- (void)addSwipeRecognizer {
    // 初始化手势并添加执行方法
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    // 手势方向
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    // 响应的手指数
    swipeRecognizer.numberOfTouchesRequired = 1;
    // 添加手势
    [[self view] addGestureRecognizer:swipeRecognizer];
}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"pig_fanhui"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"pig_fanhui"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(10, 20, 40, 44);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }

    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}

//修改电量条
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

+ (void)deleteNavLineView:(UINavigationController*)navigationController {
    if ([navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list = navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                NSArray *list2 = imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2 = (UIImageView *)obj2;
                        imageView2.hidden = YES;
                    }
                }
            }
        }
    }
    
    if ([navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list = navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {//10.0的系统字段不一样
                UIView *view = (UIView *)obj;
                for (id obj2 in view.subviews) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *image = (UIImageView *)obj2;
                        image.hidden = YES;
                    }
                }
            }
        }
    }
}

@end
