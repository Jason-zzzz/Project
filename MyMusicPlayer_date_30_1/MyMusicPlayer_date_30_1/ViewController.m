//
//  ViewController.m
//  MyMusicPlayer_date_30_1
//
//  Created by Jason_zzzz on 16/1/30.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"
#import "FirstCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define STATUSVIEW_HEIGHT 45
#define NAV_HEIGHT 64


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UIButton *button_;
    
    
//    UITableView *homeTableView_;
    
    __weak IBOutlet UIView *userMenu_;

    __weak IBOutlet UITableView *homeTableView_;
    
    // 歌曲播放状态
    __weak IBOutlet UIView *statusView_;
    __weak IBOutlet UIButton *statusMusicImage_;
    __weak IBOutlet UILabel *statusMusicName_;
    __weak IBOutlet UILabel *statusMusicText_;
    __weak IBOutlet UIButton *statusBack_;
    __weak IBOutlet UIButton *statusPlay_;
    __weak IBOutlet UIButton *statusNext_;
    __weak IBOutlet UIButton *statusMenu_;
    __weak IBOutlet UIImageView *backgroundImageView_;
}

@property (nonatomic, strong) DataModel *dataModel;

@end

@implementation ViewController

@synthesize dataModel = dataModel_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage/woman.jpg"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark Views

- (void)initView{
    // 设置背景图片
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage/woman.jpg"]]];
    
    // 毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
    effe.frame = CGRectMake(0, SCREEN_HEIGHT - STATUSVIEW_HEIGHT, SCREEN_WIDTH, STATUSVIEW_HEIGHT);
    [self.view addSubview:effe];
    [self.view addSubview:statusView_];
    
    homeTableView_.delegate = self;
    homeTableView_.dataSource = self;
    
    [self setStatusMusicImage];
}

- (void)setStatusMusicImage{
    
    // 圆形图片实际上就是设圆角
    [statusMusicImage_.layer setCornerRadius:(statusMusicImage_.frame.size.height / 2)];
    // 是否限制边界，既画圆角
    [statusMusicImage_ setClipsToBounds:YES];
//    [statusMusicImage_.layer setMasksToBounds:YES];// 同上
    
//    [statusMusicImage_ setContentMode:UIViewContentModeScaleAspectFill];
    
    // 阴影，产生立体效果
//    statusMusicImage_.layer.shadowColor = [UIColor blackColor].CGColor;
//    statusMusicImage_.layer.shadowOffset = CGSizeMake(4, 4);
//    statusMusicImage_.layer.shadowOpacity = 0.5;
    
    // 边界
//    statusMusicImage_.layer.borderColor = [[UIColor grayColor] CGColor];
//    statusMusicImage_.layer.borderWidth = 0.5f;
//    statusMusicImage_.userInteractionEnabled = YES;
    
    //是否响应手势
//    statusMusicImage_.layer.shadowRadius = 2.0;
    // 手势
//    UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMusicImage)];
//    [statusMusicImage_ addGestureRecognizer:portraitTap];
}

#pragma mark Actions

- (IBAction)leftBarButton:(id)sender {
    userMenu_.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

#pragma mark TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FirstCell *cell;
    if (indexPath.row % 2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        cell.firstCellImageView.image = [UIImage imageNamed:@"backgroundImage/sean.jpg"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
    }
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = @"浮于表面的文字";
    return cell;
}

#pragma mark TableViewDelegate



@end

