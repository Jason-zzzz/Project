//
//  Music.m
//  MyMusicPlayer_date_30_1
//
//  Created by Admin on 16/2/17.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "Music.h"

@implementation Music

@synthesize singerName = singerName_;
@synthesize musicName = musicName_;

- (id)initWithSingerName:(NSString *)singer musicName:(NSString *)music{
    if (self = [super init]) {
        singerName_ = singer;
        musicName_ = music;
    }
    return self;
}

@end
