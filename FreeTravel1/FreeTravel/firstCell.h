//
//  firstCell.h
//  FreeTravel
//
//  Created by Admin on 16/2/23.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol popViewDelegate;

@interface firstCell : UITableViewCell

@property (nonatomic, assign) id <popViewDelegate> popDelegate;

@end

@protocol popViewDelegate <NSObject>

- (void)popView: (NSInteger)tag;

@end