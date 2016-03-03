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

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate, popViewDelegate>{
    
    __weak IBOutlet UITableView *homeTableView_;
    __weak IBOutlet UIBarButtonItem *searchButton_;
    PPViewController *popVC_;
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
    
    UIImage *titleImage = [UIImage imageNamed:@"nav_back.jpg"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    titleImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    
    [self.navigationController.navigationBar addSubview:titleImageView];
    
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
    self.tabBarController.tabBar.hidden = NO;
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark popViewDelegate

- (void)popView:(NSInteger)tag{
    switch (tag) {
        case 10001:
            [self.navigationController showViewController:popVC_ sender:self];
//            popVC_.tabBarController.tabBar.hidden = YES;
            break;
            
        default:
            break;
    }
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
            return 6;
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (0 == indexPath.section) {
        firstCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier forIndexPath:indexPath];
        cell.popDelegate = self;
        return cell;
    }
    if (1 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:secendIdentifier forIndexPath:indexPath];
    }
    if (2 == indexPath.section && 0 == indexPath.row){
        thirdCell *hotCell = nil;
        hotCell = [tableView dequeueReusableCellWithIdentifier:hotMessageIdentifer forIndexPath:indexPath];
        
        return hotCell;
    }
    
    if (2 == indexPath.section && 1 == indexPath.row) {
        thirdCell *imagecell = nil;
        imagecell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"imag_08.jpg"];
        [imagecell.imageButton setImage:image forState:UIControlStateNormal];
        
        //取消选中灰色背景
        imagecell.selectionStyle = UITableViewCellSelectionStyleNone;
        return imagecell;
    }
    if (2 == indexPath.section && 2 == indexPath.row) {
        thirdCell *imagecell = nil;
        imagecell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"UUZ.jpg"];
        [imagecell.imageButton setImage:image forState:UIControlStateNormal];
        
        imagecell.selectionStyle = UITableViewCellSelectionStyleNone;
        return imagecell;
    }
    if (2 == indexPath.section && 3 == indexPath.row) {
        thirdCell *imagecell = nil;
        imagecell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"Remu.jpg"];
        imagecell.selectionStyle = UITableViewCellSelectionStyleNone;
        [imagecell.imageButton setImage:image forState:UIControlStateNormal];
        return imagecell;
    }
    if (2 == indexPath.section && 4 == indexPath.row) {
        thirdCell *imagecell = nil;
        imagecell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"UUZ.jpg"];
        imagecell.selectionStyle = UITableViewCellSelectionStyleNone;
        [imagecell.imageButton setImage:image forState:UIControlStateNormal];
        return imagecell;
    }
    if (2 == indexPath.section && 5 == indexPath.row) {
        thirdCell *imagecell = nil;
        imagecell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:@"Remu.jpg"];
        imagecell.selectionStyle = UITableViewCellSelectionStyleNone;
        [imagecell.imageButton setImage:image forState:UIControlStateNormal];
        return imagecell;
    }
    
    
   
    return cell;
}

#pragma mark UITableViewDelegate

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
        return 105;
    }
    
    return 30;
}

//设置section的header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSLog(@"123");
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


@end
