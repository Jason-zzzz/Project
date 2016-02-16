//
//  GetInternetData.h
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/22.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetInternetData : NSObject

@property (nonatomic, copy) NSDictionary *totalData;
@property (nonatomic, copy) NSDictionary *subField;
@property (nonatomic, assign) BOOL finish;

- (void)getDataForUrl: (NSString *)urlString urlRequest: (NSString *)urlRequest;
- (void)getSubField:(NSString *)urlString;
//- (void)getHomeFirstCellImage;
//- (void)getHomeSecondCellData;
//- (void)getHomeThirdCellImage;
//- (void)getHomeFourthCellData;

@end
