//
//  secendCell.h
//  FreeTravel
//
//  Created by Admin on 16/2/23.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol secondPopDelegate <NSObject>

- (void)secondPop:(NSInteger)tag;

@end

@interface secendCell : UITableViewCell

@property (nonatomic, assign) id <secondPopDelegate> delegate;

@end
