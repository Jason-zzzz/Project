//
//  PP2ViewController.m
//  FreeTravel
//
//  Created by Admin on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "PP2ViewController.h"
#import "PPfirstCell.h"
#import "WMLoopView.h"

#define CELL_HEIGHT 370

@interface PP2ViewController () <UITableViewDataSource, UITableViewDelegate, WMLoopViewDelegate> {
    UIButton *cancelButton_;
    UINib *nib_;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PP2ViewController

static NSString * firstIdentifier = @"PPfirstCell";
static NSString * secondIdentifier = @"PPsecondCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    
    self.tableView.showsVerticalScrollIndicator = NO;
    NSArray *images = @[@"zoro.jpg",@"three.jpg",@"onepiece.jpg"];
    
    WMLoopView *loopView = [[WMLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.8) images:images autoPlay:YES delay:5.0];

    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
    
    nib_ = [UINib nibWithNibName:firstIdentifier bundle:nil];
    [self.tableView registerNib:nib_ forCellReuseIdentifier:firstIdentifier];
    nib_ = [UINib nibWithNibName:secondIdentifier bundle:nil];
    [self.tableView registerNib:nib_ forCellReuseIdentifier:secondIdentifier];
}

#pragma mark Views

#pragma mark Actions

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return CELL_HEIGHT / 1000;
            break;
        case 1:
            return CELL_HEIGHT + 45;
            break;
        default:
            break;
    }
    return CELL_HEIGHT;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:secondIdentifier forIndexPath:indexPath];
    }
    if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier forIndexPath:indexPath];
    }
    return cell;
}

@end
