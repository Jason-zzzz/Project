//
//  DataModel.h
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/21.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner :NSObject

@property (nonatomic, strong) NSMutableArray *contentDict;

- (id)init;

@end

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray <NSString *>*cmSubfield;
@property (nonatomic, strong) NSArray <Banner *>* homeBannerArray;
@property (nonatomic, strong) NSMutableArray * firstCellImages;
@property (nonatomic, strong) NSArray *secondGetData;
@property (nonatomic, assign) BOOL finish;

// 获得分栏数据
- (void)getSubFieldArray: (NSDictionary *)dic;

// 处理首页图片
- (void)getHomeImage: (NSDictionary *)dic;

// 处理secondCell图片
- (void)getSecondImage: (NSDictionary *)dic;

// 处理秒杀数据
- (void)getGoodCellData: (NSDictionary *)dic;

@end
