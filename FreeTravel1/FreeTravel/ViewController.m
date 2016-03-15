//
//  ViewController.m
//  FreeTravel
//
//  Created by Admin on 16/2/23.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "ViewController.h"
#import "thirdCell.h"
#import "HotMessageCell.h"
#import "PPViewController.h"
#import "firstCell.h"
#import "PP2ViewController.h"
#import "secendCell.h"
#import "Pop3ViewController.h"
#import "WMPageController.h"
#import "WMViewController.h"
#import "WMTableViewController.h"
#import "WMCollectionViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate, popViewDelegate, secondPopDelegate>{
    
    __weak IBOutlet UITableView *homeTableView_;
    __weak IBOutlet UIBarButtonItem *searchButton_;
    PPViewController *popVC_;
    PP2ViewController *popTC_;
    Pop3ViewController *pop3VC_;
    
    WMPageController *pageController;
    WMTableViewController *wmTVC_;
}

@end

@implementation ViewController

static NSString *firstIdentifier = nil;
static NSString *secendIdentifier = nil;
static NSString *thirdIdentifier = nil;
static NSString *hotMessageIdentifer = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon1"];
    
    //设置navigation
    UIView *statusView = [[UIView alloc] init];
    statusView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 20);
    [self.navigationController.navigationBar addSubview:statusView];
    statusView.backgroundColor = [UIColor colorWithRed:0.24 green:0.78 blue:0.49 alpha:1.0];
    
//    UIImage *titleImage = [UIImage image∫Named:@"nav_back1.jpg"];
//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
//    titleImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    
//    [self.navigationController.navigationBar addSubview:titleImageView];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_02.jpg"]];
    

    //注册cell
    firstIdentifier = @"firstCell";
    UINib *nib1 = [UINib nibWithNibName:@"firstCell" bundle:nil];
    [homeTableView_ registerNib:nib1 forCellReuseIdentifier:firstIdentifier];
    
    secendIdentifier = @"secendCell";
    UINib *nib2 = [UINib nibWithNibName:@"secendCell" bundle:nil];
    [homeTableView_ registerNib:nib2 forCellReuseIdentifier:secendIdentifier];
    
    thirdIdentifier = @"thirdCell";
    UINib *nib3 = [UINib nibWithNibName:@"thirdCell" bundle:nil];
    [homeTableView_ registerNib:nib3 forCellReuseIdentifier:thirdIdentifier];
    
    hotMessageIdentifer = @"HotMessageCell";
    UINib *nib4 = [UINib nibWithNibName:@"HotMessageCell" bundle:nil];
    [homeTableView_ registerNib:nib4 forCellReuseIdentifier:hotMessageIdentifer];
    
    popVC_ = [[PPViewController alloc] init];
    popTC_ = [[PP2ViewController alloc] init];
    pop3VC_ = [[Pop3ViewController alloc] init];
    
    wmTVC_ = [[WMTableViewController alloc] init];
    
    self.tabBarController.tabBar.hidden = NO;
    // Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark Actions

- (IBAction)searchButtonAction:(id)sender {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:vc];
    searchController.dimsBackgroundDuringPresentation = YES;            //是否添加半透明覆盖层
    
//    searchController.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 375, 35)];
    searchController.searchBar.backgroundImage = [UIImage imageNamed:@"Remu.jpg"];
    searchController.hidesNavigationBarDuringPresentation = NO;     //是否隐藏导航栏
    self.definesPresentationContext = YES;
    [self.navigationController presentViewController:searchController animated:YES completion:nil];
}

#pragma mark popViewDelegate

- (void)popView:(NSInteger)tag{
    switch (tag) {
        case 10001:
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController showViewController:popVC_ sender:self];
            self.hidesBottomBarWhenPushed = NO;
            break;
           
        case 10004:
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController showViewController:popVC_ sender:self];
            self.hidesBottomBarWhenPushed = NO;
            break;
            
        case 10003:
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController showViewController:popVC_ sender:self];
            self.hidesBottomBarWhenPushed = NO;
            break;
            
        case 10002:
            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController presentViewController:wmTVC_ animated:YES completion:nil];
            
            [self.navigationController presentViewController:popTC_ animated:YES completion:nil];
            self.hidesBottomBarWhenPushed = NO;
            break;
        default:
            break;
    }
}


- (void)secondPop:(NSInteger)tag{
    switch (tag) {
        case 10020:
            [self pop3View:@"http://m.qyer.com/z/zt/flysale3&source=app&campaign=zkapp&category=zk192_flysale3/?client_id=qyer_discount_ios&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&ra_referer=app_lastminute_list&ra_model=route"];
            break;
        case 10021:
            [self pop3View:@"http://m.qyer.com/z/zt/europeart&source=app2&campaign=zkapp&category=zk192_europeart/?client_id=qyer_discount_ios&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&ra_referer=app_lastminute_list&ra_model=route"];
            break;
            
        default:
            break;
    }
}

- (void)thirdPopView:(NSInteger)tag{
    switch (tag) {
        case 10030:
//            self.hidesBottomBarWhenPushed = YES;
//            pop3VC_.requestString = @"http://m.qyer.com/z/zt/2016321go0314&source=app&campaign=zkapp&category=hot_2016321go0314/?client_id=qyer_discount_ios&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&ra_referer=choiceness&ra_model=hot_zt";
//            [self.navigationController showViewController:pop3VC_ sender:self];
//            self.hidesBottomBarWhenPushed = NO;
            
            break;
            
        default:
            break;
    }
}

#pragma mark UITableViewDelegate

- (void)pop3View: (NSString *) request {
    self.hidesBottomBarWhenPushed = YES;
    pop3VC_.requestString = request;
    [self.navigationController showViewController:pop3VC_ sender:self];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 1:
                [self pop3View:@"http://m.qyer.com/z/zt/2016321go0314&source=app&campaign=zkapp&category=hot_2016321go0314/?client_id=qyer_discount_ios&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&ra_referer=choiceness&ra_model=hot_zt"];
                break;
            case 2:
                [self pop3View:@"http://m.qyer.com/z/zt/psjtg&source=app2&campaign=zkapp&category=hot_psjtg/?client_id=qyer_discount_ios&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&ra_referer=choiceness&ra_model=hot_zt"];
                break;
            case 3:
                [self pop3View:@"http://m.qyer.com/z/zt/discovercity01&source=app2&campaign=zkapp&category=hot_discovercity01/?client_id=qyer_discount_ios&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&ra_referer=choiceness&ra_model=hot_zt"];
                break;
            case 4:
                [self pop3View:@"http://m.qyer.com/z/zt/movie&source=app&campaign=zkapp&category=hot_movie/?client_id=qyer_discount_ios&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&ra_referer=choiceness&ra_model=hot_zt"];
                break;
            case 5:
                [self pop3View:@"http://m.qyer.com/z/zt/srhd&source=app2&campaign=zkapp&category=hot_srhd/?client_id=qyer_discount_ios&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&ra_referer=choiceness&ra_model=hot_zt"];
                break;
            case 6:
                [self pop3View:@"http://m.qyer.com/z/zt/2016april&source=app2&campaign=zkapp&category=hot_2016april/?client_id=qyer_discount_ios&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&ra_referer=choiceness&ra_model=hot_zt"];
                break;
            default:
                break;
        }
    }
}

//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 113;
    }
    if (1 == indexPath.section) {
        return 73;
    }
    if (2 == indexPath.section && 0 ==indexPath.row){
        return 80;
    }
    if (2 == indexPath.section) {
        return 145;
    }
    
    return 30;
}

//设置section的header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return 1;
            break;
            
        case 2:
            return 3;
        case 3:
            return 2;
        default:
            break;
    }
    return 0.01;
}

//设置section的footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

#pragma mark UITableViewDataSource

//tableView有多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 3;
}

//指定的section中有多少个row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 8;
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        firstCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier forIndexPath:indexPath];
        cell.popDelegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (1 == indexPath.section) {
        secendCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:secendIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    
    if (2 == indexPath.section && 0 == indexPath.row){
        HotMessageCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:hotMessageIdentifer forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    thirdCell *cell = nil;
    
    if (2 == indexPath.section && 1 == indexPath.row) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"qiang.jpg"];
        cell.imageView.image = image;
        
        //取消选中灰色背景
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else
    if (2 == indexPath.section && 2 == indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"poshui.jpg"];
        cell.imageView.image = image;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else
    if (2 == indexPath.section && 3 == indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"chun.jpg"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = image;
    } else
    if (2 == indexPath.section && 4 == indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"movie.jpg"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = image;
        return cell;
    } else
    if (2 == indexPath.section && 5 == indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"shuangren.jpg"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = image;
    }
    if (2 == indexPath.section && 6 == indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"heart.jpg"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = image;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
    }
    return cell;
}


@end
