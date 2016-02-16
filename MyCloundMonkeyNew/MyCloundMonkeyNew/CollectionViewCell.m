//
//  CollectionViewCell.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/20.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell(){
    UIImageView *imageView_;
    UILabel *nameLabel_;
}

@end

@implementation CollectionViewCell

- (UIImageView *)imageView{
    if (!imageView_) {
        CGRect frame = CGRectMake(25.625, 13, 42.5, 42.5);
        imageView_ = [[UIImageView alloc] initWithFrame:frame];
//        imageView_.backgroundColor = [UIColor blackColor];
    }
    return imageView_;
}

- (UILabel *)nameLabel{
    if (!nameLabel_) {
        CGRect frame = CGRectMake(20.625, 55.5, 52.5, 20);
        nameLabel_ = [[UILabel alloc] initWithFrame:frame];
        nameLabel_.backgroundColor = [UIColor whiteColor];
//        nameLabel_.text = @"全球抢购";
        nameLabel_.textColor = [UIColor grayColor];
        nameLabel_.textAlignment = NSTextAlignmentCenter;
        nameLabel_.font = [UIFont systemFontOfSize:11];
    }
    return nameLabel_;
}

- (void)setFileName:(NSString *)fileName{
    
    [self addSubview:self.imageView];
    [self addSubview:self.nameLabel];
    
    //获取文件路径
    NSString *bundlePath = [NSBundle mainBundle].bundlePath;

    NSString *name = [NSString stringWithFormat:@"%@%@",[bundlePath stringByAppendingString:@"/collection/"],fileName];
    
    imageView_.image = [[UIImage imageWithContentsOfFile:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//image等于路径内容
    nameLabel_.text = @"全球制裁";//text等于最后的路径
}

@end
