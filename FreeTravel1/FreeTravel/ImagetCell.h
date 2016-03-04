//
//  ImagetCell.h
//  FreeTravel
//
//  Created by Admin on 16/2/24.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol loginPopDelegate <NSObject>

- (void)popLoginView: (NSInteger)tag;

@end

@interface ImagetCell : UITableViewCell

@property (nonatomic, assign) id <loginPopDelegate> loginDelegate;

@end
