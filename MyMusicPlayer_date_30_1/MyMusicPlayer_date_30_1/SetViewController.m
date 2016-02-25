//
//  SetViewController.m
//  MyMusicPlayer_date_30_1
//
//  Created by Admin on 16/2/16.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingFirstCell" forIndexPath:indexPath];
    return cell;
}

@end
