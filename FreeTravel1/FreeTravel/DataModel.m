//
//  DataModel.m
//  FreeTravel
//
//  Created by Jason_zzzz on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "DataModel.h"

NSURLRequest * (^requestBlock)(NSString *);

@interface DataModel () <NSURLSessionDelegate> {
}

@end

@implementation DataModel

@synthesize destinationState = destinationState_;
@synthesize visaData = visaData_;

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self defaultObject];
}

+ (DataModel *)defaultObject{
    
    static DataModel *singleInstance = nil;
    if (!singleInstance) {
        singleInstance = [[super allocWithZone:NULL] init];
        
        requestBlock = ^(NSString * urlString){
            // 构建Request
            NSString *encodeUrl = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            //    NSLog(@"%@",encodeUrl);
            NSURL *url = [NSURL URLWithString:encodeUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            return request;
        };
    }
    return singleInstance;
}

- (void)getDataByAF {
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:destinationData parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
}

- (void)getDestinationData: (NSString *)desUrl {
    NSURLRequest *request = requestBlock(desUrl);
    // 构建session的congigurations
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 构建NSUrlSession
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    void (^aBlock)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dataDic = [dic objectForKey:@"data"];
//        NSLog(@"%@",dataDic);
        NSDictionary *poiDic = [dataDic objectForKey:@"poi"];
        for (NSDictionary *continent in poiDic) {
//            NSLog(@"%@", [continent objectForKey:@"continent_name"]);
//            NSLog(@"%@", [continent objectForKey:@"country"]);
            NSDictionary *countryDic = [continent objectForKey:@"country"];
            for (NSDictionary *cityDic in countryDic) {
                NSDictionary *cityList = [cityDic objectForKey:@"city_list"];
                NSLog(@"%@", cityList);
            }
        }
//        NSLog(@"==-==-==-==-%@",poiDic);
    };
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:aBlock];
    [dataTask resume];
}

- (void)getData:(NSString *)urlString{

    NSURLRequest *request = requestBlock(urlString);
    // 构建session的congigurations
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 构建NSUrlSession
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    void (^aBlock)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([urlString isEqualToString:basicData]) {
            destinationState_ = [dic objectForKey:@"data"];
            [_modelDelegate finishGetData];
        }
        if ([urlString isEqualToString:visa]) {
            visaData_ = [dic objectForKey:@"data"];
            //                NSLog(@"%@",visaData_);
            [_visaModelDelegate finishGetVisa];
        }
    };
    if (destinationState_ && [urlString isEqualToString:basicData]) {
        [_modelDelegate finishGetData];
        return;
    } else if (visaData_ && [urlString isEqualToString:visa]) {
        [_visaModelDelegate finishGetVisa];
        return;
    }
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:aBlock];
    [dataTask resume];
}
 
- (void)getVisaImageWith: (NSString *) visaImageUrl andNum: (NSInteger)num {
    // 异步下载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 下载
        NSURL *url = [NSURL URLWithString:visaImageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        [_visaModelDelegate finishGetVisaImage:image andNum:num];
    });
}

- (void)getCityImagesWith:(NSIndexPath *)cityIndex tableRow:(NSInteger)tableRow andUrl:(NSString *)cityImageUrl {
    
    // 异步下载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 下载
        NSURL *url = [NSURL URLWithString:cityImageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        [_modelDelegate finishGetCityImage:image tableRow:tableRow andIndex:cityIndex];
    });
}


@end
