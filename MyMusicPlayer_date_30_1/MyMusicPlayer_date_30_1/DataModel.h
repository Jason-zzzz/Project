//
//  DataModel.h
//  MyMusicPlayer_date_30_1
//
//  Created by Jason_zzzz on 16/1/30.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DataModelDelegate;

@interface DataModel : NSObject

// 声明一个遵循DataModelDelegate协议的实例属性
@property (nonatomic, assign) id <DataModelDelegate> modelDelegate;
// 声明一个外部可访问的ID属性供测试使用
@property (nonatomic, assign) NSInteger ID;



// 单例类创建的类方法
+ (DataModel *)defaultObject;

// 获取数据
- (void)getImage;


@end

// DataModel协议
@protocol DataModelDelegate <NSObject>

@optional
- (void)didFinishGetData: (id)data;

@end
