//
//  MusicStatusView.m
//  MyMusicPlayer_date_30_1
//
//  Created by Jason_zzzz on 16/2/1.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "MusicStatusView.h"

#define STATUSVIEW_HEIGHT 45
#define MERGE 3

@interface MusicStatusView(){
    UIImageView *musicImageView_;
}
@end

@implementation MusicStatusView

- (id)init{
    if (self = [super init]) {
        [self addSubview:self.musicImageView];
    }
    return self;
}

- (UIImageView *)musicImageView{
    if (!musicImageView_) {
        CGFloat w = STATUSVIEW_HEIGHT - MERGE * 2;
        CGFloat h = w;
        CGFloat x = MERGE * 1.5;
        CGFloat y = MERGE;
        
        // 圆形图片实际上就是设圆角
        musicImageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [musicImageView_.layer setCornerRadius:(musicImageView_.frame.size.height/2)];
        [musicImageView_.layer setMasksToBounds:YES];
        [musicImageView_ setContentMode:UIViewContentModeScaleAspectFill];
        [musicImageView_ setClipsToBounds:YES];
        musicImageView_.layer.shadowColor = [UIColor blackColor].CGColor;
        musicImageView_.layer.shadowOffset = CGSizeMake(4, 4);
        musicImageView_.layer.shadowOpacity = 0.5;
        musicImageView_.layer.shadowRadius = 2.0;
        musicImageView_.layer.borderColor = [[UIColor blackColor] CGColor];
        musicImageView_.layer.borderWidth = 0.0f;
        musicImageView_.userInteractionEnabled = YES;
        musicImageView_.backgroundColor = [UIColor blackColor];
        musicImageView_.image = [UIImage imageNamed:@"backgroundImage/sean.jpg"];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMusicImage)];
        [musicImageView_ addGestureRecognizer:portraitTap];
    }
    return musicImageView_;
}

- (void)selectMusicImage{
    NSLog(@"123");
}

@end
