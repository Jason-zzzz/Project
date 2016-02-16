//
//  TableViewGoodCell.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/21.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "TableViewGoodCell.h"
#import "PriceLabel.h"

#define screenWidth               [[UIScreen mainScreen] bounds].size.width
#define screenHeight              [[UIScreen mainScreen] bounds].size.height

@interface TableViewGoodCell(){
    UILabel *remaindText_;
    UIImageView *remaindImageView_;
    UIButton *shopButton_;
    PriceLabel *priceLabel_;
}

@end

@implementation TableViewGoodCell

@synthesize goodImageView = goodImageView_;
@synthesize remaindTime = remaindTime_;
@synthesize goodIntroduce = goodIntroduce_;
@synthesize goodNowPrice = goodNowPrice_;
@synthesize goodAbondonPrice = goodAbondonPrice_;
@synthesize remianTimeNumber = remainTimeNumber_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.goodImageView];
        [self addSubview:self.remaindText];
        [self addSubview:self.goodIntroduce];
        [self addSubview:self.remaindTime];
        [self addSubview:self.remaindImageView];
        [self addSubview:self.goodNowPrice];
        
        // 重绘label
        [self addSubview:self.goodAbondonPrice];
        [self addSubview:self.shopButton];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUrlString:(NSString *)urlString{
    // 异步下载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 1.下载globle
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];

        
        // 2.回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            self.goodImageView.image =  image;
        });
    });

}

- (UIImageView *)goodImageView{
    if (!goodImageView_) {
        CGRect frame = CGRectMake(0, 0, 135, 135);
        goodImageView_ = [[UIImageView alloc] initWithFrame:frame];
//        goodImageView_.backgroundColor = [UIColor redColor];
    }
    return goodImageView_;
}

- (UILabel *)remaindText{
    if (!remaindText_) {
        CGRect frame = CGRectMake(goodImageView_.bounds.size.width, 9, 60, 30);
        remaindText_ = [[UILabel alloc] initWithFrame:frame];
        remaindText_.text = @"剩余时间";
        remaindText_.textAlignment = NSTextAlignmentLeft;
        remaindText_.font = [UIFont fontWithName:@"Menlo" size:13];
        remaindText_.textColor = [UIColor grayColor];
    }
    return remaindText_;
}

- (UILabel *)goodIntroduce{
    if (!goodIntroduce_) {
        CGRect frame = CGRectMake(goodImageView_.bounds.size.width, remaindText_.bounds.origin.y + 35, screenWidth - goodImageView_.bounds.size.width - 25, 54);
        goodIntroduce_ = [[UILabel alloc] initWithFrame:frame];
        goodIntroduce_.text = @"【hehehe】剩余时间间Nature Mode间时间时间 时间时间时间时间 时间时间时间 时时时";
        goodIntroduce_.textAlignment = NSTextAlignmentLeft;
        goodIntroduce_.numberOfLines = 0;
//        NSLog(@"%@",[UIFont familyNames]);
        goodIntroduce_.font = [UIFont fontWithName:@"Helvetica" size:15];
        goodIntroduce_.textColor = [UIColor blackColor];
    }
    return goodIntroduce_;
}

- (UIImageView *)remaindImageView{
    if (!remaindImageView_) {
        CGRect frame = CGRectMake(0, 0, 20, 20);
        remaindImageView_ = [[UIImageView alloc] initWithFrame:frame];
        remaindImageView_.center = CGPointMake(screenWidth - 85.5 , remaindText_.center.y);
        remaindImageView_.image = [UIImage imageNamed:@"remaindTime.jpeg"];
    }
    return remaindImageView_;
}

- (UILabel *)remaindTime{
    if (!remaindTime_) {
        CGRect frame = CGRectMake(0, 0, 70, 30);
        remaindTime_ = [[UILabel alloc] initWithFrame:frame];
        remaindTime_.center = CGPointMake(screenWidth - 38, remaindText_.center.y);
        remaindTime_.text = @"12:12:10";
        remaindTime_.textAlignment = NSTextAlignmentLeft;
        remaindTime_.numberOfLines = 0;
        //        goodIntroduce_.lineBreakMode = NSLineBreakByCharWrapping;
        remaindTime_.font = [UIFont systemFontOfSize:13];
        remaindTime_.textColor = [UIColor redColor];
        NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate distantPast] interval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    return remaindTime_;
}

- (UILabel *)goodNowPrice{
    if (!goodNowPrice_) {
        CGRect frame = CGRectMake(goodImageView_.bounds.size.width, 93, 80, 30);
        goodNowPrice_ = [[UILabel alloc] initWithFrame:frame];
        goodNowPrice_.text = @"$150";
        goodNowPrice_.textAlignment = NSTextAlignmentLeft;
//        goodNowPrice_.backgroundColor = [UIColor blueColor];
        goodNowPrice_.font = [UIFont fontWithName:@"Menlo" size:18];
        goodNowPrice_.textColor = [UIColor redColor];
    }
    return goodNowPrice_;
}

- (UILabel *)goodAbondonPrice{
    if (!goodAbondonPrice_) {
        CGRect frame = CGRectMake(goodImageView_.bounds.size.width + goodNowPrice_.bounds.size.width + 5, 98, 60, 20);
        goodAbondonPrice_ = [[UILabel alloc] initWithFrame:frame];
        goodAbondonPrice_.text = @"$150";
        goodAbondonPrice_.textAlignment = NSTextAlignmentLeft;
        goodAbondonPrice_.font = [UIFont fontWithName:@"Menlo" size:13];
//        goodAbondonPrice_.backgroundColor = [UIColor blueColor];
        goodAbondonPrice_.textColor = [UIColor grayColor];
    }
    return goodAbondonPrice_;
}

// 重绘的label
- (UILabel *)priceLabel{
    if (!priceLabel_) {
        CGRect frame = CGRectMake(goodImageView_.bounds.size.width, 85, 160, 45);
        priceLabel_ = [[PriceLabel alloc] initWithFrame:frame];
        priceLabel_.text = @"$15fds呵呵的撒欧国家搜狗";
//        priceLabel_.textAlignment = NSTextAlignmentLeft;
//        priceLabel_.font = [UIFont fontWithName:@"Menlo" size:19];
//        priceLabel_.textColor = [UIColor redColor];
    }
    return priceLabel_;
}

- (UIButton *)shopButton{
    if (!shopButton_) {
        shopButton_ = [UIButton buttonWithType:UIButtonTypeSystem];
        CGRect frame = CGRectMake(screenWidth - 48, 95, 22, 22);
        shopButton_.frame = frame;
//        shopButton_.backgroundColor = [UIColor redColor];
        
        UIImage *image = [UIImage imageNamed:@"shopCar.jpeg"];
        [shopButton_ setBackgroundImage:image forState:UIControlStateNormal];
        [shopButton_ addTarget:self action:@selector(shopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return shopButton_;
}

// 画分割线
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置cell背景色
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    // 分割线颜色
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.212 green:0.212 blue:0.212 alpha:0.230].CGColor);
    // 分割线粗细
    CGContextStrokeRect(context, CGRectMake(5, -1, screenWidth, 1));
}

#pragma mark Actions

- (IBAction)timerAction:(id)sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (remainTimeNumber_ > 0) {
            self.remaindTime.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld" ,self.remianTimeNumber / 1000 / 3600 ,self.remianTimeNumber / 1000 / 60 % 60 ,self.remianTimeNumber / 1000 % 60];
            remainTimeNumber_ -= 1000;
        }else{
            self.remaindTime.text = [NSString stringWithFormat:@"00:00:00"];
        }
//        NSLog(@"%ld",remainTimeNumber_);
    });
}

- (IBAction)shopButtonAction:(id)sender{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"成功加入购物车" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    promptAlert.frame = CGRectMake(0, 0, 50, 30);
    promptAlert.center = self.center;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    
    [promptAlert show];
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    promptAlert =NULL;
}

@end
