//
//  DataModel.h
//  FreeTravel
//
//  Created by Jason_zzzz on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol dataModelDelegate <NSObject>

- (void)finishGetData;
- (void)finishGetCityImage: (UIImage *)image andIndex: (NSIndexPath *) index;

@end

@interface DataModel : NSObject

@property (nonatomic, assign) id <dataModelDelegate> modelDelegate;
@property (nonatomic, copy) NSMutableArray <NSString *> * destinationState;

+ (DataModel *)defaultObject;

- (void)getData: (NSString *) urlString;
- (void)getCityImagesWith: (NSIndexPath *) cityIndex andUrl: (NSString *) cityImageUrl;

@end
