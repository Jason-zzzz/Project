//
//  GetInternetData.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/22.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "GetInternetData.h"

@interface GetInternetData() <NSURLSessionDelegate>{
    NSNotificationCenter *notificationCenter_;
}

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *urlRequest;

@end

@implementation GetInternetData

@synthesize subField = subField_;
@synthesize totalData = totalData_;
@synthesize urlRequest = urlRequest_;
@synthesize urlString = urlString_;

- (id)init{
    if (self = [super init]) {
        
        totalData_ = [NSDictionary dictionary];
        subField_ = [NSDictionary dictionary];
        
        // 获取通知中心实例
        notificationCenter_ = [NSNotificationCenter defaultCenter];
        
        // 在通知中心添加观察者
        [notificationCenter_ addObserver:self selector:@selector(setDataForProject:) name:key object:self];
    }
    return self;
}

static NSString *key = @"123";
static _Bool isSub = 0;
static NSInteger count = 0;

// 数据设置
- (void)setDataForProject: (NSNotification *)notification{
    if (!isSub) {
        totalData_ = notification.userInfo;
        count++;
    }else if(isSub == 1){
        subField_ = notification.userInfo;
        count++;
    }
    if (count == 2) {
        _finish = YES;
    }
}

//通用网络接口
- (void)getDataForUrl: (NSString *)urlString urlRequest: (NSString *)urlRequest{
    
//    NSString *param1 = @"params=";
//    NSString *urlString1 = @"http://global.api.yunhou.com/yunhou-global-api/service?method=bubugao.mobile.global.index.recommend.get&version=1.4.1";
    
    urlRequest_ = urlRequest;
    urlString_ = urlString;
    
    // 构建URL
    NSString *encodeUrlString = [urlString_ stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodeUrlString];
    
    // 生成参数
    NSString *encodeParam = [urlRequest_ stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSData *paramData = [encodeParam dataUsingEncoding:NSUTF8StringEncoding];
    
    // 构建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:paramData];
    
    // 构建Session的configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 构建NSURLSession
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    // 得到Task对象
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNotification *notification = [[NSNotification alloc] initWithName:key object:self userInfo:returnDic];
        isSub = 0;
        [notificationCenter_ postNotification:notification];
        
    }];
    
    [dataTask resume];
}

- (void)getSubField:(NSString *)urlString{
 
    // 获取分栏数据
    // 构建Request
    //    NSString  *urlString = @"http://global.api.yunhou.com/yunhou-global-api/service?method=bubugao.mobile.global.sysParamAndLoading.get&version=1.4.1&eCode=225bff88a45918a&mChannel=App Store&params={'sourceType':'2'}&phoneModel=iPhone&source=ios&systemVersion=IOS9.2&uCode=195858116e65781&version=1.4.1&versionCode=28";
    NSString *encodeUrl = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //    NSLog(@"%@",encodeUrl);
    NSURL *url = [NSURL URLWithString:encodeUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 构建session的congigurations
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 构建NSUrlSession
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    // 得到Task对象
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //        NSLog(@"%@",dic);
        NSDictionary *dataDict = [dic objectForKey:@"data"];
        
        NSNotification *notification = [[NSNotification alloc] initWithName:key object:self userInfo:dataDict];
        isSub = 1;
        [notificationCenter_ postNotification:notification];
    }];
    
    [dataTask resume];
    
    
}

@end
