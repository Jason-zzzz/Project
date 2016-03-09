//
//  DesModel.h
//  FreeTravel
//
//  Created by Admin on 16/3/7.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DesModelDelegate;

@interface DesModel : NSObject

@property (nonatomic, assign) id<DesModelDelegate> delegate;

@end

@protocol DesModelDelegate <NSObject>
//返回CollectionCell数组
- (void)DesCollectionCell:(NSArray *)CollectionArr;

@end