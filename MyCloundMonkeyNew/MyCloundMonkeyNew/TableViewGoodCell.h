//
//  TableViewGoodCell.h
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/21.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewGoodCell : UITableViewCell

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) NSInteger remianTimeNumber;
@property (nonatomic, strong) UIImageView *goodImageView;
@property (nonatomic, strong) UILabel *remaindTime;
@property (nonatomic, strong) UILabel *goodIntroduce;
@property (nonatomic, strong) UILabel *goodNowPrice;
@property (nonatomic, strong) UILabel *goodAbondonPrice;

@end
