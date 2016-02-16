//
//  AdDataModel.m
//  广告循环滚动效果
//
//  Created by QzydeMac on 14/12/20.
//  Copyright (c) 2014年 Qzy. All rights reserved.
//

#import "AdDataModel.h"
#import "DataModel.h"

#define PLISTFILENAME @"AdDataPlist.plist"

#define PATH  [[NSBundle mainBundle]pathForResource:PLISTFILENAME ofType:nil]


@implementation AdDataModel

- (instancetype)initWithImageName
{
    self = [super init];
    if (self)
    {
        DataModel *dataModel;
        _imageNameArray = [NSArray arrayWithArray:dataModel.firstCellImages];
    }
    return self;
}

- (instancetype)initWithImageNameAndAdTitleArray
{
    _adTitleArray = [NSArray arrayWithContentsOfFile:PATH][1];
    
    return [self initWithImageName];
}

+ (id)adDataModelWithImageName
{
    return [[self alloc]initWithImageName];
}

+ (id)adDataModelWithImageNameAndAdTitleArray
{
    return [[self alloc]initWithImageNameAndAdTitleArray];
}
@end
