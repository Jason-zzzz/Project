//
//  thirdCell.h
//  FreeTravel
//
//  Created by Admin on 16/2/23.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol thirdPopDelegate <NSObject>

- (void)thirdPopView: (NSInteger)tag;

@end

@interface thirdCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (nonatomic, assign) id <thirdPopDelegate> delegate;

@end
