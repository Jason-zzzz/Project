//
//  DataModel.m
//  FreeTravel
//
//  Created by Jason_zzzz on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "DataModel.h"

@interface DataModel () <NSURLSessionDelegate>

@end

@implementation DataModel

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self defaultObject];
}

+ (DataModel *)defaultObject{
    
    static DataModel *singleInstance = nil;
    if (!singleInstance) {
        singleInstance = [[super allocWithZone:NULL] init];
    }
    return singleInstance;
}

- (id)init{
    if (self = [super init]) {
        [self getData:nil];
    }
    return self;
}

- (void)getData:(NSString *)urlString{
    
    // 获取分栏数据
    // 构建Request
    urlString = @"http://open.qyer.com/lastminute/app_selected_product?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&track_device_info=iPhone7,2&lon=104.0880427151395&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&track_user_id=&track_os=ios%25209.2.1&track_app_version=1.9.3&size=375x667&lat=30.55730853290911&track_app_channel=App%2520Store&app_installtime=1456065462&ra_referer=app_home&page=1&pageSize=10";
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
//                NSLog(@"%@",dic);
        NSDictionary *dataDict = [dic objectForKey:@"data"];
    }];
    
    [dataTask resume];
    
}


@end
