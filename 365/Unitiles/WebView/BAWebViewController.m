//
//  BAWebViewController.m
//  365
//
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAWebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface BAWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@end

@implementation BAWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //状态栏中的大标题
    self.title = _titleStr;
    
    UIView *backView = [[UIView alloc] initWithFrame:self.view.frame];
    backView.backgroundColor = [UIColor colorWithRed:1.00f green:0.68f blue:0.07f alpha:1.00f];
    [self.view addSubview:backView];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight-64)];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [_webView removeFromSuperview];
    [self.view addSubview:_webView];
    
    [self loadWithURL];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"从htmlData===%@", data);
        if ([data isEqualToString:@"风险评估成功"]) {
            
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadWithURL {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    NSString *returnUrl = @"商户回调URL";
    if ([url.absoluteString rangeOfString:returnUrl].location != NSNotFound) {
        
    }
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"正在加载"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MMProgressHUD dismiss];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MMProgressHUD dismissWithError:@""];
}


@end
