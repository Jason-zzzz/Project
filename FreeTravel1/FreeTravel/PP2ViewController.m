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
#import "DataModel.h"
#import "VisaData.h"

#define CELL_HEIGHT 370

@interface PP2ViewController () <UITableViewDataSource, UITableViewDelegate, WMLoopViewDelegate, visaDataDelegate> {
    UIButton *cancelButton_;
    UINib *nib_;
    WMLoopView *loopView;
    NSArray *images;
    DataModel *dataModel_;
    NSMutableArray *slideImages;
    NSMutableArray *slideImages1;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PP2ViewController

static NSString * firstIdentifier = @"PPfirstCell";
static NSString * secondIdentifier = @"PPsecondCell";

- (id)init {
    if (self = [super init]) {
        
        self.visaSlideArray = [NSArray array];
        self.visaCityArray = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    slideImages = [NSMutableArray array];
    slideImages1 = [NSMutableArray array];
    for (NSInteger i = 0; i < self.visaSlideArray.count; i++) {
        [slideImages addObject:@""];
        [slideImages1 addObject:@""];
    }
    dataModel_ = [DataModel allocWithZone:NULL];
    dataModel_.visaModelDelegate = self;
    [self initView];
    loopView.images = slideImages;
    
    [self getImage];
}

#pragma mark dataModelDelegate

- (void)finishGetVisaImage:(UIImage *)image andNum:(NSInteger)num {
    slideImages1[num] = image;
    if (num == self.visaSlideArray.count - 1) {
        loopView.images = slideImages1;
    }
}

- (void)getImage {
    for (NSInteger i = 0; i < self.visaSlideArray.count; i++) {
        [dataModel_ getVisaImageWith:((VisaData *)self.visaSlideArray[i]).imgUrl andNum:i];
//        NSLog(@"%@",((VisaData *)self.visaSlideArray[i]).imgUrl);
    }
}

- (void)initView {
    
    self.tableView.showsVerticalScrollIndicator = NO;
//    images = @[@"zoro.jpg",@"three.jpg"];
    
    loopView = [[WMLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.8) images:slideImages autoPlay:YES delay:2.0];
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
