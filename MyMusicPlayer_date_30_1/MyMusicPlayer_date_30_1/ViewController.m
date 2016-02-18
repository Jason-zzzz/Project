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
#import "Music.h"
#import <AVFoundation/AVFoundation.h>

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
    __weak IBOutlet UITableView *LRCTableView_;
    __weak IBOutlet UISlider *playSlider_;
    __weak IBOutlet UILabel *currentTimeLabel_;
    
    // 播放器及相应数据
    AVAudioPlayer *audioPlayer_;
    NSMutableArray  *musicArray_;
    NSInteger currentMusicArrayNumber_;
    Music *currentMusic_;
    BOOL isPlay_;
    NSMutableDictionary *LRCDictionary_;
    NSMutableArray *timeArray_;
    NSTimer *timer_;
    NSInteger LRCLineNumber_;
}

@property (nonatomic, strong) DataModel *dataModel;

@end

@implementation ViewController

@synthesize dataModel = dataModel_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化界面
    [self initView];
    
    // 初始化播放器状态
    [self initPlayerStatus];
}


#pragma mark Actions

- (IBAction)leftBarButton:(id)sender {
    userMenu_.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

// 开始播放
- (IBAction)playButtonAction:(id)sender {
    
    if (!isPlay_) {
        [audioPlayer_ play];
        [statusPlay_ setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        isPlay_ = YES;
    }else{
        [audioPlayer_ pause];
        [statusPlay_ setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        isPlay_ = NO;
    }
}

// 上一首
- (IBAction)backButtonAction:(id)sender {
    
    if (currentMusicArrayNumber_ > 0) {
        currentMusicArrayNumber_--;
    }else{
        currentMusicArrayNumber_ = musicArray_.count - 1;
    }
    [self refreshPlayerStatus];
}

// 下一首
- (IBAction)nextButtonAction:(id)sender {
    
    if (currentMusicArrayNumber_ < musicArray_.count - 1) {
        currentMusicArrayNumber_++;
    }else{
        currentMusicArrayNumber_ = 0;
    }
    [self refreshPlayerStatus];
}

- (void)timerAction{
//    NSLog(@"12");
    [self displaySondWord:audioPlayer_.currentTime];
}

#pragma mark Methods

- (void)initView{
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage/womanTitle.jpg"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // 设置背景图片
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage/woman.jpg"]]];
    
    // 毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
    effe.frame = CGRectMake(0, SCREEN_HEIGHT - STATUSVIEW_HEIGHT, SCREEN_WIDTH, STATUSVIEW_HEIGHT);
    [self.view addSubview:effe];
    [self.view addSubview:statusView_];
    
    // 初始化播放进度条
    [playSlider_ setThumbImage:[UIImage imageNamed:@"sliderThumb_small.png"] forState:UIControlStateNormal];
    [playSlider_ setThumbImage:[UIImage imageNamed:@"sliderThumb_small.png"] forState:UIControlStateHighlighted];
    
    currentTimeLabel_.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    
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

// 初始化播放器状态
- (void)initPlayerStatus{
    
    // 添加歌曲项目数据
    [self initMusicData];
    
    currentMusicArrayNumber_ = 0;
    NSLog(@"%@----%ld",[musicArray_[currentMusicArrayNumber_] musicName],musicArray_.count);
    audioPlayer_ = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[musicArray_[currentMusicArrayNumber_] musicName] ofType:@"mp3"]] error:nil];
    
    // 初始化歌词，时间.initWithCapacity并不影响实际使用的大小，只是给一个相近的初值会提高程序的效率
    timeArray_ = [[NSMutableArray alloc] initWithCapacity:10];
    LRCDictionary_ = [[NSMutableDictionary alloc] initWithCapacity:10];
    [self initLRC];
    
    //后台播放音频设置
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //让app支持接受远程控制事件
    //    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    if (!timer_) {
        timer_ = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    
    currentMusic_ = musicArray_[currentMusicArrayNumber_];
    [self setText];
    
    NSLog(@"4++++++++++++++++++++++++%f",audioPlayer_.duration);
//    [self displaySondWord:audioPlayer_.currentTime];
    
    isPlay_ = NO;
}

// 更新播放器状态
- (void)refreshPlayerStatus{
    
    //重新载入歌词词典  清空数据,或者重新初始化这两个变量分配大致空间，防止浪费
    [timeArray_ removeAllObjects];
    [LRCDictionary_ removeAllObjects];
//    timeArray_ = [[NSMutableArray alloc] initWithCapacity:10];
//    LRCDictionary_ = [[NSMutableDictionary alloc] initWithCapacity:10];
    // 重载歌词
    [self initLRC];
    // 重载歌词单
    [LRCTableView_ reloadData];
    
    // 对于audioPlayer，只能用重新初始化的方法来播放下一首歌曲
    audioPlayer_ = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[musicArray_[currentMusicArrayNumber_] musicName] ofType:@"mp3"]] error:nil];
    currentMusic_ = musicArray_[currentMusicArrayNumber_];
    [self setText];
    if (isPlay_) {
        [audioPlayer_ play];
    }
    
    NSLog(@"%f",audioPlayer_.duration);
}

// 得到歌词数据
- (void)initLRC {
    NSString *LRCPath = [[NSBundle mainBundle] pathForResource:[musicArray_[currentMusicArrayNumber_] musicName] ofType:@"lrc"];
    NSString *contentStr = [NSString stringWithContentsOfFile:LRCPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"contentStr = %@",contentStr);
    NSArray *array = [contentStr componentsSeparatedByString:@"\n"];
    for (int i = 0; i < [array count]; i++) {
        NSString *linStr = [array objectAtIndex:i];
        NSArray *lineArray = [linStr componentsSeparatedByString:@"]"];
        if ([lineArray[0] length] > 8) {
            NSString *str1 = [linStr substringWithRange:NSMakeRange(3, 1)];
            //                                NSLog(@"%@",str1);
            NSString *str2 = [linStr substringWithRange:NSMakeRange(6, 1)];
            //                                NSLog(@"%@",str2);
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                NSString *lrcStr = [lineArray objectAtIndex:1];
                NSString *timeStr = [[lineArray objectAtIndex:0] substringWithRange:NSMakeRange(1, 5)];//分割区间求歌词时间
                //把时间 和 歌词 加入词典
                [LRCDictionary_ setObject:lrcStr forKey:timeStr];
                [timeArray_ addObject:timeStr];//timeArray的count就是行数
            }
        }
    }
    NSLog(@"%ld",timeArray_.count);
}

// 动态显示歌词
- (void)displaySondWord:(NSUInteger)time {
    //    NSLog(@"time = %u",time);
    for (int i = 0; i < [timeArray_ count]; i++) {
        
        NSArray *array = [timeArray_[i] componentsSeparatedByString:@":"];//把时间转换成秒
        NSUInteger currentTime = [array[0] intValue] * 60 + [array[1] intValue];
        if (i == [timeArray_ count]-1) {
            //求最后一句歌词的时间点
            NSArray *array1 = [timeArray_[timeArray_.count-1] componentsSeparatedByString:@":"];
            NSUInteger currentTime1 = [array1[0] intValue] * 60 + [array1[1] intValue];
            if (time > currentTime1) {
                [self refreshLrcTableView:i];
                break;
            }
        } else {
            //求出第一句的时间点，在第一句显示前的时间内一直加载第一句
            NSArray *array2 = [timeArray_[0] componentsSeparatedByString:@":"];
            NSUInteger currentTime2 = [array2[0] intValue] * 60 + [array2[1] intValue];
            if (time < currentTime2) {
                [self refreshLrcTableView:0];
                //                NSLog(@"马上到第一句");
                break;
            }
            //求出下一步的歌词时间点，然后计算区间
            NSArray *array3 = [timeArray_[i+1] componentsSeparatedByString:@":"];
            NSUInteger currentTime3 = [array3[0] intValue] * 60 + [array3[1] intValue];
            if (time >= currentTime && time <= currentTime3) {
                [self refreshLrcTableView:i];
                break;
            }
            
        }
        statusMusicText_.text = [LRCDictionary_ objectForKey:timeArray_[i + 1]];
    }
}

// 更新歌词表
- (void)refreshLrcTableView:(NSUInteger)lineNumber {
    //    NSLog(@"lrc = %@", [LRCDictionary objectForKey:[timeArray objectAtIndex:lineNumber]]);
    //重新载入 歌词列表lrcTabView
    LRCLineNumber_ = lineNumber;
    [LRCTableView_ reloadData];
    //使被选中的行移到中间
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lineNumber inSection:0];
//    NSLog(@"%@,%ld",indexPath,lineNumber);
    [LRCTableView_ selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    //    NSLog(@"%i",lineNumber);
}

// 显示歌名及歌词信息
- (void)setText{
    
    statusMusicName_.text = currentMusic_.musicName;
    statusMusicText_.text = currentMusic_.singerName;
}

// 得到歌曲数据
- (void)initMusicData{
    
    musicArray_ = [NSMutableArray array];
    
    Music *music1 = [[Music alloc] initWithSingerName:@"林俊杰" musicName:@"林俊杰-背对背拥抱"];
    Music *music2 = [[Music alloc] initWithSingerName:@"梁静茹" musicName:@"梁静茹-偶阵雨"];
    Music *music3 = [[Music alloc] initWithSingerName:@"无" musicName:@"情非得已"];
    
    [musicArray_ addObject:music1];
    [musicArray_ addObject:music2];
    [musicArray_ addObject:music3];
    
//    NSString *path = [NSString stringWithString:[NSBundle mainBundle]];
}

#pragma mark TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%ld",timeArray_.count);
    if (tableView == homeTableView_) {
        return 5;
    }else if(tableView == LRCTableView_){
        return timeArray_.count + 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == homeTableView_) {
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == homeTableView_) {
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

    }else if(tableView == LRCTableView_){
        
        static NSString *cellIdentifier = @"LRCCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//该表格选中后没有颜色
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        //        cell.textLabel.textColor = [UIColor blackColor];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        //        [cell.contentView addSubview:lable];//往列表视图里加 label视图，然后自行布局
        if (indexPath.row == timeArray_.count - 1){
            return cell;
        }else{
            if (indexPath.row == LRCLineNumber_) {
                cell.textLabel.text = LRCDictionary_[timeArray_[indexPath.row]];
                cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
                cell.textLabel.font = [UIFont systemFontOfSize:20];
            } else {
                cell.textLabel.text = LRCDictionary_[timeArray_[indexPath.row]];
                cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
                cell.textLabel.font = [UIFont systemFontOfSize:17];
            }
            return cell;
        }
    }
    return nil;
}

#pragma mark TableViewDelegate

@end

