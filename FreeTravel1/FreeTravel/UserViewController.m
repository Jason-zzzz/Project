//
//  UserViewController.m
//  FreeTravel
//
//  Created by Admin on 16/2/24.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "UserViewController.h"
#import "SecondCell.h"
#import "ImagetCell.h"
#import "LastCell.h"
#import "LoginViewController.h"

//屏幕宽、高 宏定义
#define IPHONE_W ([UIScreen mainScreen].bounds.size.width)
#define IPHONE_H ([UIScreen mainScreen].bounds.size.height)


@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource, loginPopDelegate> {
    LoginViewController *loginVC_;
}

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation UserViewController

static NSString *imageReuseIdentifier = nil;
static NSString *secondReuseIdentifier = nil;
static NSString *lastReuseIdentifier = nil;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *statusView = [[UIView alloc] init];
    statusView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 20);
    [self.navigationController.navigationBar addSubview:statusView];
    statusView.backgroundColor = [UIColor colorWithRed:0.24 green:0.78 blue:0.49 alpha:1.0];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_02.jpg"]];
    
    self.navigationController.hidesBarsOnSwipe = YES;
    imageReuseIdentifier = @"ImagetCell";
    UINib *imageNib = [UINib nibWithNibName:@"ImagetCell" bundle:nil];
    [_userTableView registerNib:imageNib forCellReuseIdentifier:imageReuseIdentifier];
    
    secondReuseIdentifier = @"SecondCell";
    UINib *secondNib = [UINib nibWithNibName:@"SecondCell" bundle:nil];
    [_userTableView registerNib:secondNib forCellReuseIdentifier:secondReuseIdentifier];
    
    lastReuseIdentifier = @"LastCell";
    UINib *lastNib = [UINib nibWithNibName:@"LastCell" bundle:nil];
    [_userTableView registerNib:lastNib forCellReuseIdentifier:lastReuseIdentifier];
    
    loginVC_ = [[LoginViewController alloc] init];
//    [self addChildViewController:loginVC_];
//    loginVC_.view.frame = CGRectMake(0, IPHONE_H * 2, IPHONE_W, IPHONE_H);
}

- (void)popLoginView:(NSInteger)tag {
    switch (tag) {
        case 10010:
            [self.navigationController presentViewController:loginVC_ animated:YES completion:nil];
            break;
        default:
            break;
    }
}

- (void)popLoginView{
    [UIView animateWithDuration:0.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        loginVC_.view.center = self.view.center;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark UITableViewDelegate & DataSource

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1:
            [self.navigationController presentViewController:loginVC_ animated:YES completion:nil];
            break;
            
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 5;
    }
        return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160.0;
    }
    if (indexPath.section == 1) {
        return 50.0;
    }
    return 50.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    if (0 == indexPath.section) {
        ImagetCell *imageCell = nil;
        imageCell = [tableView dequeueReusableCellWithIdentifier:imageReuseIdentifier forIndexPath:indexPath];
        imageCell.loginDelegate = self;
//        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(130, 100, 50, 30)];
//         [button setTitle:@"首页" forState:UIControlStateNormal];
        return imageCell;
    }
    if (1 == indexPath.section) {
        SecondCell *cell1 = nil;
        cell1 = [tableView dequeueReusableCellWithIdentifier:secondReuseIdentifier forIndexPath:indexPath];
        NSArray *arr = @[@"我的订单",@"我的优惠",@"我的收藏",@"我的咨询",@"我的提醒"];
        UIImage *image1[5];
        for (int i =0; i<5; i++) {
            NSString *s = [NSString stringWithFormat:@"icon-%d",i+1];
            UIImage *image = [UIImage imageNamed:s];
            image1[i] = image;
        }
        cell1.secondLabel.text = arr[indexPath.row];
        cell1.secondImage.image = image1[indexPath.row];

        return cell1;
    }
    
    if (2 == indexPath.section) {
        LastCell *cell = nil;
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:lastReuseIdentifier forIndexPath:indexPath];
            cell.lastImage.image = [UIImage imageNamed:@"icon-6"];
            cell.lastLabel.text = @"常用旅客信息";
        }
        if (indexPath.row == 1) {
            cell = [tableView dequeueReusableCellWithIdentifier:lastReuseIdentifier forIndexPath:indexPath];
            cell.lastImage.image = [UIImage imageNamed:@"icon-5"];
            cell.lastLabel.text = @"常用联系人";
        }
        if (indexPath.row == 2) {
            cell = [tableView dequeueReusableCellWithIdentifier:lastReuseIdentifier forIndexPath:indexPath];
            cell.lastImage.image = [UIImage imageNamed:@"icon-8.png"];
            cell.lastLabel.text = @"常用旅客信息";
        }


        
        return cell;
    }
    
    return cell;
}


@end
