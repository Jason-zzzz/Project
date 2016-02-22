//
//  MenuViewController.h
//  MyMusicPlayer_date_30_1
//
//  Created by Jason_zzzz on 16/2/2.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface MenuViewController : UIViewController

@property (weak,nonatomic)  ViewController  *myMusic;

@end

@protocol SelectDelegate <NSObject>

@required
- (void)didSelected: (NSInteger)row;

@end