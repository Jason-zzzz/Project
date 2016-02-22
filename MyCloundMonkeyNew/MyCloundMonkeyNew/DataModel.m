//
//  DataModel.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/21.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "DataModel.h"

@interface DataModel()<NSURLSessionDelegate, NSURLSessionDownloadDelegate>{
    Banner *banner_;
    NSDictionary *data_;
    NSString *Url_;
    NSString *encodeUrlString_;
    NSURL *url_;
    NSURLRequest *request_;
    NSURLSessionConfiguration *sessionConfig_;
    NSURLSession *session_;
    NSURLSessionDownloadTask *task_;
}

@end

@implementation Banner

@synthesize contentDict = contentDict_;
- (id)init{
    if (self = [super init]) {
        contentDict_ = [NSMutableArray array];
    }
    return self;
}

@end

@implementation DataModel

@synthesize cmSubfield = cmSubfield_;
@synthesize finish = finish_;
@synthesize firstCellImages = firstCellImages_;
@synthesize secondGetData = secondGetData_;

- (id)init{
    if (self = [super init]) {
        banner_ = [[Banner alloc] init];
        cmSubfield_ = [NSMutableArray array];
        firstCellImages_ = [NSMutableArray array];
        finish_ = 0;
    }
    return self;
}

- (void)getSubFieldArray:(NSDictionary *)dic{
        NSArray *homeDataDict = [dic objectForKey:@"tabVos"];

        for (NSInteger i = 0; i < homeDataDict.count; i++) {
            NSDictionary *dic = (NSDictionary *)homeDataDict[i];
            [cmSubfield_ addObject:[dic objectForKey:@"name"]];
        }
}

- (void)getHomeImage:(NSDictionary *)dic{
    
    // 获取data数据
    data_ = [dic objectForKey:@"data"];
    
    // 获取firstCell图片
    NSArray *chars = [data_ objectForKey:@"chars"];
    b = chars.count;
    for (NSInteger i = 0; i < chars.count; i++) {
        Url_ = [chars[i] objectForKey:@"adImg"];

        
        // 创建请求对象
        encodeUrlString_ = [Url_ stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        url_ = [NSURL URLWithString:encodeUrlString_];
        request_ = [NSURLRequest requestWithURL:url_];
        
        
        // 创建会话配置对象
        sessionConfig_ = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 创建会话对象
        session_ = [NSURLSession sessionWithConfiguration:sessionConfig_ delegate:self delegateQueue:nil];
        
        
        // 获取downloadTask对象
        task_ = [session_ downloadTaskWithRequest:request_];
        [task_ resume];
    }
}

static NSInteger a = 0;
static NSInteger b = 0;

- (void)getSecondImage:(NSDictionary *)dic{
    
}

- (void)getGoodCellData:(NSDictionary *)dic{
    NSDictionary *data = [dic objectForKey:@"data"];
    NSDictionary *secKillActivity = [data objectForKey:@"secKillActivity"];
    secondGetData_ = [secKillActivity objectForKey:@"products"];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    // 将下载的文件拷贝到/Library/Preferences目录中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *libraryUrl = [fileManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask][0];
    NSURL *preferencesURL = [libraryUrl URLByAppendingPathComponent:@"Preferences"];
    NSURL *desURL = [preferencesURL URLByAppendingPathComponent:[location lastPathComponent]];
    
//    [fileManager removeItemAtURL:preferencesURL  error:nil];// 删除同名文件
    
//        删除sandbox 里面的Documents目录里面的文件夹
//        NSArray *contents，里面对应的是文件夹里面的内容，可以使用NSLog()打印输出
//        然后通过NSEnumerator枚举出来。判断扩展名是否为tmp，如果是，则删除。
    NSString *extension = @"tmp";
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
    

    [fileManager copyItemAtURL:location toURL:desURL error:nil];// 目标目录有同名文件会报错
    NSLog(@"%@",desURL);
    [firstCellImages_ addObject:[desURL path]];
    
    a++;
    if (a == b) {
        finish_ = 1;
    }
}

@end
