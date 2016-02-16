//
//  HomeTableViewThirdCell.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/21.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "HomeTableViewThirdCell.h"

#define screenWidth               [[UIScreen mainScreen] bounds].size.width
#define screenHeight              [[UIScreen mainScreen] bounds].size.height

@interface HomeTableViewThirdCell(){
    UIImageView *imageView_;
}

@end

@implementation HomeTableViewThirdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.imageView];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UIImageView *)imageView{
    if (!imageView_) {
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
        imageView_ = [[UIImageView alloc] initWithFrame:frame];
        UIImage *image = [UIImage imageNamed:@"secondGet.jpeg"];
        imageView_.image = image;
        imageView_.contentMode = UIViewContentModeScaleToFill;
    }
    return imageView_;
}

// 画分割线
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.212 green:0.212 blue:0.212 alpha:0.230].CGColor);
    CGContextStrokeRect(context, CGRectMake(5, -1, screenWidth, 1));
}

@end
