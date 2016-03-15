//
//  CollectionViewCell.m
//  FreeTravel
//
//  Created by Admin on 16/3/7.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *chineseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *engNameLabel;

@end

@implementation CollectionViewCell

- (void)setChineseName:(NSString *)chineseName {
    self.chineseNameLabel.text = chineseName;
    [self.chineseNameLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
}

- (void)setEngName:(NSString *)engName {
    self.engNameLabel.text = engName;
}

@end
