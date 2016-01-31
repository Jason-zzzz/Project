//
//  SecondViewController.m
//  MyMusicPlayer_date_30_1
//
//  Created by Jason_zzzz on 16/1/30.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "SecondViewController.h"
#import "DataModel.h"

@interface SecondViewController ()<DataModelDelegate>{
    UIImageView *imageView_;
    DataModel *dataModel_;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    dataModel_ = [[DataModel allocWithZone:NULL] init];
    dataModel_.modelDelegate = self;

    
    NSLog(@"Second.ID = %ld",dataModel_.ID);
    [self.view addSubview:self.imageView];
    

    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // 取数据
    [dataModel_ getImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Views

- (UIImageView *)imageView{
    if (!imageView_) {
        imageView_ = [[UIImageView alloc] init];
        imageView_.frame = CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 200);
        imageView_.backgroundColor = [UIColor whiteColor];
//        imageView_.image = [dataModel_ getImage];
    }
    return imageView_;
}

#pragma mark DataModelDelegate

- (void)didFinishGetData: (id)data{
    
    UIImage *image = [UIImage imageWithData:data];
    
    // 注意此处使用dispatch_async方法，具体原因未知
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView_.image = image;
        imageView_.backgroundColor = [UIColor blueColor];
    });
}

@end
