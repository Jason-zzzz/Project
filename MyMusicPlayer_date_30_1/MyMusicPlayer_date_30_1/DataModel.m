//
//  DataModel.m
//  MyMusicPlayer_date_30_1
//
//  Created by Jason_zzzz on 16/1/30.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "DataModel.h"

@interface DataModel()

@end

@implementation DataModel

// 创建实例单例
+ (DataModel *)defaultObject{
    
    static DataModel *dataModelInstance = nil;
    
    if (!dataModelInstance) {
        dataModelInstance = [[super allocWithZone:NULL] init];
    }
    
    return dataModelInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self defaultObject];
}

// 获取数据
- (void)getImage{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [UIImage imageWithData:data];
//    NSLog(@"%@",data);
    [_modelDelegate didFinishGetData:data];
}

@end
