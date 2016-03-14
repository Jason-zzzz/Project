//
//  DataModel.h
//  FreeTravel
//
//  Created by Jason_zzzz on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol dataModelDelegate <NSObject>

- (void)finishGetData;

@end

@interface DataModel : NSObject

@property (nonatomic, assign) id <dataModelDelegate> modelDelegate;
@property (nonatomic, copy) NSMutableArray <NSString *> * destinationState;

+ (DataModel *)defaultObject;

@end
