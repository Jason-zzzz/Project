//
//  WMTableViewController.m
//  WMPageController
//
//  Created by Mark on 15/6/13.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMTableViewController.h"
#import "WMLoopView.h"
#import "WMPageConst.h"
#import "PPfirstCell.h"
#import "WMImageViewCell.h"

@interface WMTableViewController () <WMLoopViewDelegate> {
    PPfirstCell *ppCell_;
    UIButton *cancelButton_;
}

@property (nonatomic, strong) NSArray *imageNames;

@end

@implementation WMTableViewController

static NSString * firstIdentifier = @"ppFirstCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    [self.view addSubview:self.cancelButton];
}

- (void)initView{
    
    self.tableView.showsVerticalScrollIndicator = NO;
    NSArray *images = @[@"zoro.jpg",@"three.jpg",@"onepiece.jpg"];
    WMLoopView *loopView = [[WMLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.8) images:images autoPlay:YES delay:10.0];
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
    self.tableView.rowHeight = 80;
    NSLog(@"%@", self.age);
    
    UINib *nib = [UINib nibWithNibName:@"PPfirstCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:firstIdentifier];
}


#pragma mark Views

- (UIButton *)cancelButton {
    if (!cancelButton_) {
        cancelButton_ = [UIButton buttonWithType:UIButtonTypeSystem];
        CGRect frame = CGRectMake(20, 40, 25, 25);
        cancelButton_.frame = frame;
        [cancelButton_ setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [cancelButton_ addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return cancelButton_;
}

#pragma mark Actions

- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ppCell_ = [tableView dequeueReusableCellWithIdentifier:firstIdentifier forIndexPath:indexPath];
    return ppCell_;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com