//
//  ViewController.m
//  MyMusicPlayer_date_30_1
//
//  Created by Jason_zzzz on 16/1/30.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"
#import "SecondViewController.h"

@interface ViewController (){
    UIButton *button_;
}

@property (nonatomic, strong) DataModel *dataModel;

@end

@implementation ViewController

@synthesize dataModel = dataModel_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataModel_ = [[DataModel allocWithZone:NULL] init];
    DataModel *dataModel2 = [[DataModel allocWithZone:NULL] init];
    dataModel2.ID = 2;
    dataModel_.ID = 3;
    
    NSLog(@"dataModel.ID = %ld,dataModel2.ID = %ld",dataModel_.ID,dataModel_.ID);
    
    [self.view addSubview:self.button];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIButton *)button{
    if (!button_) {
        button_ = [UIButton buttonWithType:UIButtonTypeSystem];
        button_.frame = CGRectMake(200, 200, 50, 30);
        [button_ setTitle:@"点我" forState:UIControlStateNormal];
        [button_ addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return button_;
}

- (IBAction)buttonAction:(id)sender{
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self presentViewController:secondViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
