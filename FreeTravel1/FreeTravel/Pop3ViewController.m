//
//  Pop3ViewController.m
//  FreeTravel
//
//  Created by Admin on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "Pop3ViewController.h"

@interface Pop3ViewController () <UIWebViewDelegate>

@end

@implementation Pop3ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_pop3Web stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML='';"];
    [self loadWeb];
}

- (void)loadWeb{
    // 支持http
    // 在Info.plist中添加NSAppTransportSecurity类型Dictionary。
    // 在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES
    
    // 1、链接地址转码(因为有的服务器不能解析含有中文字符的url，如果是全英文，则转换后内容不变)
    
    NSString *encoderUrlString = [_requestString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 2、创建url对象
    NSURL *url = [NSURL URLWithString:encoderUrlString];
    
    // 3、创建网络请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发起网络请求
    [_pop3Web loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSURL *url = [request URL];
//        if([[UIApplication sharedApplication]canOpenURL:url])
//        {
//            [[UIApplication sharedApplication]openURL:url];
//        }
        NSLog(@"--------------%@--------------------", url);
        return NO;
    }
    return YES;
}


@end
