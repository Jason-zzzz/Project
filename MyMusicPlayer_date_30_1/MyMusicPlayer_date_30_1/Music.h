//
//  Music.h
//  MyMusicPlayer_date_30_1
//
//  Created by Admin on 16/2/17.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic, copy) NSString *musicName;
@property (nonatomic, copy) NSString *singerName;

- (id)initWithSingerName: (NSString *)singer musicName: (NSString *)music;

@end
