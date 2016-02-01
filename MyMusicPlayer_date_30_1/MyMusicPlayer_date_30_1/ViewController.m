//
//  ViewController.m
//  MyMusicPlayer_date_30_1
//
//  Created by Jason_zzzz on 16/1/30.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"
#import "MusicStatusView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define STATUSVIEW_HEIGHT 45
#define NAV_HEIGHT 64


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UIButton *button_;
    
    // 背景图片,取用本地图片
    UIImageView *backgroundImageView_;
    
    UITableView *homeTableView_;
    
    // 歌曲播放状态
    MusicStatusView *musicStatusView_;
}

@property (nonatomic, strong) DataModel *dataModel;

@end

@implementation ViewController

@synthesize dataModel = dataModel_;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.view addSubview:self.homeTableView];
    [self.view addSubview:self.musicStatusView];
}

#pragma mark Views

- (UIImageView *)backgroundImageView{
    if (!backgroundImageView_) {
        backgroundImageView_ = [[UIImageView alloc] init];
        backgroundImageView_.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        backgroundImageView_.image = [UIImage imageNamed:@"backgroundImage/woman.jpg"];
    }
    return backgroundImageView_;
}

- (UITableView *)homeTableView{
    if (!homeTableView_) {
        homeTableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) style:UITableViewStyleGrouped];
        homeTableView_.backgroundColor = [UIColor clearColor];
        homeTableView_.backgroundView = self.backgroundImageView;
        homeTableView_.delegate = self;
        homeTableView_.dataSource = self;
    }
    return homeTableView_;
}

- (UIView *)musicStatusView{
    if (!musicStatusView_) {
        musicStatusView_ = [[MusicStatusView alloc] init];
        musicStatusView_.frame = CGRectMake(0, SCREEN_HEIGHT - STATUSVIEW_HEIGHT, SCREEN_WIDTH, STATUSVIEW_HEIGHT);
//        musicStatusView_.backgroundColor = [UIColor whiteColor];
        musicStatusView_.backgroundColor = [UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:0.85];
    }
    return musicStatusView_;
}

#pragma mark TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = @"浮于表面的文字";
    
    return cell;
}

@end

