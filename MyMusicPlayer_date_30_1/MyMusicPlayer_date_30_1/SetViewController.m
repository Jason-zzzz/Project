//
//  SetViewController.m
//  MyMusicPlayer_date_30_1
//
//  Created by Admin on 16/2/16.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray <NSString *> *stringArr_;
}

@end

@implementation SetViewController

@synthesize setButton = setButton_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    stringArr_ = @[@"我的",@"你的",@"他的",@"设置",@"歌曲",@"主题",@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingFirstCell" forIndexPath:indexPath];
    setButton_.titleLabel.text = stringArr_[indexPath.row];
    return cell;
}

@end
