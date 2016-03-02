//
//  FSDropDownMenu2.h
//  FSDropDownMenu2
//
//  Created by xiang-chen on 14/12/17.
//  Copyright (c) 2014年 chx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSDropDownMenu2;

@protocol FSDropDownMenu2DataSource <NSObject>

@required
- (NSInteger)menu:(FSDropDownMenu2 *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString *)menu:(FSDropDownMenu2 *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - delegate
@protocol FSDropDownMenu2Delegate <NSObject>
@optional
- (void)menu:(FSDropDownMenu2 *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface FSDropDownMenu2 : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) UIView *transformView;

@property (nonatomic, weak) id <FSDropDownMenu2DataSource> dataSource;
@property (nonatomic, weak) id <FSDropDownMenu2Delegate> delegate;

- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;

-(void)menuTapped;

@end
