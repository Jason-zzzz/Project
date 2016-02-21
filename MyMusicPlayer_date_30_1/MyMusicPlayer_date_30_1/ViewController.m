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
#import <CoreText/CoreText.h>
#import "GlobalFont.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define STATUSVIEW_HEIGHT 45
#define NAV_HEIGHT 64


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UIButton *button_;
    
    
    //    UITableView *homeTableView_;
    
    __weak IBOutlet UIView *userMenu_;
    
    __weak IBOutlet UITableView *homeTableView_;
    __weak IBOutlet UIImageView *backgroundImageView_;
    
    // 歌曲播放状态视图
    __weak IBOutlet UIView *statusView_;
    __weak IBOutlet UIButton *statusMusicImage_;
    __weak IBOutlet UILabel *statusMusicName_;
    __weak IBOutlet UILabel *statusMusicText_;
    __weak IBOutlet UIButton *statusBack_;
    __weak IBOutlet UIButton *statusPlay_;
    __weak IBOutlet UIButton *statusNext_;
    __weak IBOutlet UIButton *statusMenu_;
    __weak IBOutlet UITableView *LRCTableView_;
    __weak IBOutlet UISlider *playSlider_;
    __weak IBOutlet UILabel *currentTimeLabel_;
    __weak IBOutlet UITableView *MusicList_;
    
    // 歌曲列表
    __weak IBOutlet UIView *musicList_;
    BOOL isShowing_;
    
    // 播放器及相应数据
    AVAudioPlayer *audioPlayer_;
    NSMutableArray  *musicArray_;
    NSInteger currentMusicArrayNumber_;
    Music *currentMusic_;
    BOOL isPlay_;
    BOOL isPlayButton_;
    NSMutableDictionary *LRCDictionary_;
    NSMutableArray *timeArray_;
    NSTimer *timer_;
    NSInteger LRCLineNumber_;
    
    // 毛玻璃
    UIVisualEffectView * effectView_;
    UIVisualEffectView *musicListEffeView_;
}

@property (nonatomic, strong) DataModel *dataModel;

@end

@implementation ViewController

@synthesize dataModel = dataModel_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化界面
    // datasourece创建cell时既初始化了cell的text
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
    
    isPlayButton_ = YES;
    
    if (!timer_) {
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_sync(globalQueue, ^{
            timer_ = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        });
    }
    
    if (!isPlay_) {
        isPlay_ = YES;
        [self refreshPlayerStatus];
    }else{
        isPlay_ = NO;
        [self refreshPlayerStatus];
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

// Slider值改变时调用
- (IBAction)playSliderAction:(id)sender {
    audioPlayer_.currentTime = (int)playSlider_.value;
    [self displaySondWord:audioPlayer_.currentTime];
    [self setCurrentTimeLabel];
}

// 拖动到下一首
- (void)dragToNext{
    if (playSlider_.value != 0 && playSlider_.value == (int)audioPlayer_.duration) {
        [self nextButtonAction:statusNext_];
    }
    NSLog(@"playSlider.value--%f",playSlider_.value);
}

static NSInteger timersTime = 0;
- (void)timerAction{
    
    // 进度条更新值
    timersTime++;
    if (timersTime % 10 == 0){
        playSlider_.value++;
    }
    if (!isShowing_) {
        [self setCurrentTimeLabel];
    }
    
    [self displaySondWord:audioPlayer_.currentTime];
    // 由于硬件原因不能精确比较时间判断歌曲播放进度，所以结束时提前1毫秒.
    if ((int)(audioPlayer_.currentTime * 10) == (int)(audioPlayer_.duration * 10 - 1)){
//                                [playSlider_ resignFirstResponder];
//                                playSlider_.enabled = NO;
        [self nextButtonAction:statusNext_];

        [self displaySondWord:0.0f];
        playSlider_.value = 0;
        [self setText];
    }
}


// 弹出歌曲列表
static NSInteger playSliderCenterY = 0;
- (IBAction)statusMenu:(id)sender {
    isShowing_ = YES;
//    statusMusicText_.enabled = NO;
    
    //添加动画 [UIView animateWithDuration:2 animations:^] 其中2为总共移动2秒，animation激活
    [UIView animateWithDuration:0.4 animations:^{
        //UIViewAnimationCurveEaseInOut  设置动画移动模式的属性
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        statusView_.center = CGPointMake(statusView_.center.x , SCREEN_HEIGHT + statusView_.bounds.size.height / 2 + currentTimeLabel_.bounds.size.height);
        playSliderCenterY = SCREEN_HEIGHT - playSlider_.center.y;
        playSlider_.center = CGPointMake(playSlider_.center.x, SCREEN_HEIGHT + playSliderCenterY);
        effectView_.center = CGPointMake(effectView_.center.x, SCREEN_HEIGHT + effectView_.bounds.size.height / 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            musicList_.center = CGPointMake(musicList_.center.x, SCREEN_HEIGHT / 4 * 3);
            musicListEffeView_.center = CGPointMake(musicListEffeView_.center.x, SCREEN_HEIGHT / 4 * 3);
        } completion:^(BOOL finished) {
            // TODO
        }];
    }];
}

// 收回歌曲列表
- (IBAction)closeMusicList:(id)sender {
    
    [UIView animateWithDuration:0.4 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        musicList_.center = CGPointMake(musicList_.center.x, SCREEN_HEIGHT / 4 * 5);
        musicListEffeView_.center = CGPointMake(musicListEffeView_.center.x, SCREEN_HEIGHT / 4 * 5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            statusView_.center = CGPointMake(statusView_.center.x , SCREEN_HEIGHT - statusView_.bounds.size.height / 2);
            playSlider_.center = CGPointMake(playSlider_.center.x, SCREEN_HEIGHT - playSliderCenterY);
            effectView_.center = CGPointMake(effectView_.center.x, SCREEN_HEIGHT - effectView_.bounds.size.height / 2);
        } completion:^(BOOL finished) {
            isShowing_ = NO;
        }];
    }];
   
}

#pragma mark Methods

- (void)initView{
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage/womanTitle.jpg"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    /Users/jason_zzzz/Desktop/资源/字体/方正兰亭纤黑_GBK.TTF
    // 添加字体
//    [self customFontArrayWithPath:@"/Users/jason_zzzz/Desktop/资源/字体/方正兰亭纤黑_GBK.TTF" size:12];
    
    // 设置背景图片
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage/woman.jpg"]]];
    
    // 毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    effectView_ = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView_.frame = CGRectMake(0, SCREEN_HEIGHT - STATUSVIEW_HEIGHT, SCREEN_WIDTH, STATUSVIEW_HEIGHT);
    musicListEffeView_ = [[UIVisualEffectView alloc]initWithEffect:blur];
    musicListEffeView_.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, musicList_.bounds.size.height);
    isShowing_ = NO;
    [self.view addSubview:effectView_];
    [self.view addSubview:musicListEffeView_];
    [self.view addSubview:musicList_];
    [self.view addSubview:statusView_];
    
    
    // 初始化播放进度条
    [playSlider_ setThumbImage:[UIImage imageNamed:@"sliderThumb_small.png"] forState:UIControlStateNormal];
    [playSlider_ setThumbImage:[UIImage imageNamed:@"sliderThumb_small.png"] forState:UIControlStateHighlighted];
    [playSlider_ addTarget:self action:@selector(dragToNext) forControlEvents:UIControlEventTouchUpInside];
    [playSlider_ addTarget:self action:@selector(dragToNext) forControlEvents:UIControlEventTouchUpOutside];
    
    currentTimeLabel_.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    
    [self setStatusMusicImage];
    
}

- (void)setStatusMusicImage{
    
    // 圆形图片实际上就是设圆角
    [statusMusicImage_.layer setCornerRadius:(statusMusicImage_.frame.size.height / 2)];
    // 是否限制边界，既画圆角
    [statusMusicImage_ setClipsToBounds:YES];
    
//        [statusMusicImage_.layer setMasksToBounds:YES];// 同上
//    
//        [statusMusicImage_ setContentMode:UIViewContentModeScaleAspectFill];
//    
//     阴影，产生立体效果
//        statusMusicImage_.layer.shadowColor = [UIColor blackColor].CGColor;
//        statusMusicImage_.layer.shadowOffset = CGSizeMake(4, 4);
//        statusMusicImage_.layer.shadowOpacity = 0.5;
//    
//     边界
//        statusMusicImage_.layer.borderColor = [[UIColor grayColor] CGColor];
//        statusMusicImage_.layer.borderWidth = 0.5f;
//        statusMusicImage_.userInteractionEnabled = YES;
//    
//    是否响应手势
//        statusMusicImage_.layer.shadowRadius = 2.0;
//     手势
//        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMusicImage)];
//        [statusMusicImage_ addGestureRecognizer:portraitTap];
}

// 初始化播放器状态
- (void)initPlayerStatus{
    
//     添加歌曲项目数据
    [self initMusicData];
    
    currentMusicArrayNumber_ = 0;
//    NSLog(@"%@----%ld",[musicArray_[currentMusicArrayNumber_] musicName],musicArray_.count);
    audioPlayer_ = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[musicArray_[currentMusicArrayNumber_] musicName] ofType:@"mp3"]] error:nil];
    
//     初始化歌词，时间.initWithCapacity并不影响实际使用的大小，只是给一个相近的初值会提高程序的效率
    timeArray_ = [[NSMutableArray alloc] initWithCapacity:10];
    LRCDictionary_ = [[NSMutableDictionary alloc] initWithCapacity:10];
    [self initLRC];
    
    // 初始化slider
    playSlider_.maximumValue = (int)audioPlayer_.duration;
    
//    后台播放音频设置
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//    让app支持接受远程控制事件
//        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    currentMusic_ = musicArray_[currentMusicArrayNumber_];
    [self setText];
    
//    NSLog(@"4++++++++++++++++++++++++%f",audioPlayer_.duration);
//        [self displaySondWord:audioPlayer_.currentTime];
    
    isPlay_ = NO;
    isPlayButton_ = NO;
}

// 更新播放器状态
- (void)refreshPlayerStatus{
    
    if (isPlayButton_) {
        isPlayButton_ = NO;
        if (isPlay_) {
            // 将timer启动时间设为无限过去
                    [timer_ setFireDate:[NSDate distantPast]];
            
                    [audioPlayer_ play];
                    [statusPlay_ setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
                    statusMusicText_.text = @"正在播放";
        }else{
                    [audioPlayer_ pause];
                    // 彻底停止并销毁timer
//                    [timer_ invalidate];
            ////        timer_ = nil;
                    // 将timer启动时间设为无限未来
                    [timer_ setFireDate:[NSDate distantFuture]];
                    [statusPlay_ setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                    statusMusicText_.text = @"暂停播放";
        }
    }else{
        
        // 重新载入歌词词典  清空数据,或者重新初始化这两个变量分配大致空间，防止浪费
        [timeArray_ removeAllObjects];
        [LRCDictionary_ removeAllObjects];
        //        timeArray_ = [[NSMutableArray alloc] initWithCapacity:10];
        //        LRCDictionary_ = [[NSMutableDictionary alloc] initWithCapacity:10];
        // 重载歌词
        [self initLRC];
        // 重载歌词页
        [LRCTableView_ reloadData];
        [LRCTableView_ reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [self refreshLrcTableView:0];
        
        // 对于audioPlayer，只能用重新初始化的方法来播放下一首歌曲
        audioPlayer_ = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[musicArray_[currentMusicArrayNumber_] musicName] ofType:@"mp3"]] error:nil];
        currentMusic_ = musicArray_[currentMusicArrayNumber_];
        
        //     设置slider的初始值
        playSlider_.value = 0;
        playSlider_.maximumValue = (int)audioPlayer_.duration;
        
        [self setText];
        [self setCurrentTimeLabel];
        if (isPlay_) {
            statusMusicText_.text = @"正在播放";
            [audioPlayer_ play];
        }else{
            //TODO
        }
    }
    
    NSLog(@"duration:%f",audioPlayer_.duration);
}

// 得到歌词数据
- (void)initLRC {
    NSString *LRCPath = [[NSBundle mainBundle] pathForResource:[musicArray_[currentMusicArrayNumber_] musicName] ofType:@"lrc"];
    NSString *contentStr = [NSString stringWithContentsOfFile:LRCPath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"contentStr = %@",contentStr);
    NSArray *array = [contentStr componentsSeparatedByString:@"\n"];
    for (int i = 0; i < [array count]; i++) {
        NSString *linStr = [array objectAtIndex:i];
        NSArray *lineArray = [linStr componentsSeparatedByString:@"]"];
        if ([lineArray[0] length] > 8) {
            NSString *str1 = [linStr substringWithRange:NSMakeRange(3, 1)];
//                                            NSLog(@"%@",str1);
            NSString *str2 = [linStr substringWithRange:NSMakeRange(6, 1)];
//                                            NSLog(@"%@",str2);
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                NSString *lrcStr = [lineArray objectAtIndex:1];
                NSString *timeStr = [[lineArray objectAtIndex:0] substringWithRange:NSMakeRange(1, 5)];//分割区间求歌词时间
                // 把时间和歌词加入词典
                [LRCDictionary_ setObject:lrcStr forKey:timeStr];
                [timeArray_ addObject:timeStr];//timeArray的count就是行数
            }
        }
    }
    NSLog(@"%ld",timeArray_.count);
}

// 动态显示歌词
- (void)displaySondWord:(NSUInteger)time {
//        NSLog(@"time = %u",time);
    for (int i = 0; i < [timeArray_ count]; i++) {
        
        NSArray *array = [timeArray_[i] componentsSeparatedByString:@":"];// 把时间转换成秒
        NSUInteger currentTime = [array[0] intValue] * 60 + [array[1] intValue];
        if (i == [timeArray_ count]-1) {
            // 求最后一句歌词的时间点
            NSArray *array1 = [timeArray_[timeArray_.count-1] componentsSeparatedByString:@":"];
            NSUInteger currentTime1 = [array1[0] intValue] * 60 + [array1[1] intValue];
            if (time > currentTime1) {
                [self refreshLrcTableView:i];
                break;
            }
        }else{
            // 求出第一句的时间点，在第一句显示前的时间内一直加载第一句
            NSArray *array2 = [timeArray_[0] componentsSeparatedByString:@":"];
            NSUInteger currentTime2 = [array2[0] intValue] * 60 + [array2[1] intValue];
            if (time < currentTime2) {
                [self refreshLrcTableView:0];
                //                                NSLog(@"马上到第一句");
                break;
            }
            // 求出下一步的歌词时间点，然后计算区间
            NSArray *array3 = [timeArray_[i+1] componentsSeparatedByString:@":"];
            NSUInteger currentTime3 = [array3[0] intValue] * 60 + [array3[1] intValue];
            if (time >= currentTime && time <= currentTime3) {
                [self refreshLrcTableView:i];
                break;
            }
        }
    }
}

// 更新歌词表
- (void)refreshLrcTableView:(NSUInteger)lineNumber {
//        NSLog(@"lrc = %@", [LRCDictionary objectForKey:[timeArray objectAtIndex:lineNumber]]);
    
    // 重新载入歌词列表lrcTabView
    if (LRCLineNumber_ != lineNumber) {
        LRCLineNumber_ = lineNumber;
        [LRCTableView_ reloadData];
        
        // 使被选中的行移到中间
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lineNumber inSection:0];
//            NSLog(@"%@,%ld",indexPath,lineNumber);
        [LRCTableView_ selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
//        NSLog(@"%i",lineNumber);
}

// 显示歌名及歌词信息
- (void)setText{
    
    statusMusicName_.text = currentMusic_.musicName;
    statusMusicText_.text = currentMusic_.singerName;
}

// 显示目前时间
- (void)setCurrentTimeLabel{
    currentTimeLabel_.text = [NSString stringWithFormat:@"%02d:%02d",(int)playSlider_.value / 60,(int)playSlider_.value % 60];
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
    
}

#pragma mark TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//        NSLog(@"%ld",timeArray_.count);
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
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//            }
//        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.textLabel.text = @"浮于表面的文字";
        return cell;
        
    }else if(tableView == LRCTableView_){
        
        static NSString *cellIdentifier = @"LRCCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;// 该表格选中后没有颜色
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
//                cell.textLabel.textColor = [UIColor blackColor];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
//                [cell.contentView addSubview:lable];// 往列表视图里加label视图，然后自行布局
        if (indexPath.row == timeArray_.count){
            cell.textLabel.text = nil;
            return cell;
        }else{
            if (indexPath.row == LRCLineNumber_) {
                cell.textLabel.text = LRCDictionary_[timeArray_[indexPath.row]];
                cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
                cell.textLabel.font = [UIFont systemFontOfSize:18.5];// fontWithName:@"FZLanTingHei-EL-GBK" size:19];
            } else {
                cell.textLabel.text = LRCDictionary_[timeArray_[indexPath.row]];
                cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.55];
                cell.textLabel.font = [UIFont systemFontOfSize:17];// fontWithName:@"FZLanTingHei-EL-GBK" size:16];
            }
            return cell;
        }
    }
    return nil;
}

#pragma mark TableViewDelegate

@end

