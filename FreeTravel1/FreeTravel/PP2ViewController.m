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
#import "PP2CollectionViewCell.h"
#import "PPViewController.h"

#define CELL_HEIGHT 370
#define collectionCellWidth 100

@interface PP2ViewController () <UITableViewDataSource, UITableViewDelegate, WMLoopViewDelegate, visaDataDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
    UIButton *cancelButton_;
    UINib *nib_;
    WMLoopView *loopView;
    NSArray *images;
    DataModel *dataModel_;
    NSMutableArray *slideImages;
    NSTimer *timer;
    UICollectionView *collectionViewPlus;
    PPViewController *p1VC;
}
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
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
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(initView) userInfo:nil repeats:YES];
}

#pragma mark dataModelDelegate

- (void)finishGetVisaImage:(UIImage *)image andNum:(NSInteger)num {
    if (num < self.visaSlideArray.count) {
        slideImages[num] = image;
        loopView.images = slideImages;
    }
}

- (void)getImage {
    for (NSInteger i = 0; i < self.visaSlideArray.count; i++) {
        [dataModel_ getVisaImageWith:((VisaData *)self.visaSlideArray[i]).imgUrl andNum:i];
//        NSLog(@"%@",((VisaData *)self.visaSlideArray[i]).imgUrl);
        
        dataModel_.visaModelDelegate = self;
    }
}


#pragma mark Views

- (void)initView {
    
    if (self.visaSlideArray.count == 0) {
        self.errorLabel.hidden = NO;
        return;
    }
    self.errorLabel.hidden = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self initCollectionView];
    dataModel_ = [DataModel allocWithZone:NULL];
    
    nib_ = [UINib nibWithNibName:firstIdentifier bundle:nil];
    [self.tableView registerNib:nib_ forCellReuseIdentifier:firstIdentifier];
    nib_ = [UINib nibWithNibName:secondIdentifier bundle:nil];
    [self.tableView registerNib:nib_ forCellReuseIdentifier:secondIdentifier];
    
    timer.fireDate = [NSDate distantFuture];
    
    
    slideImages = [NSMutableArray array];
    for (NSInteger i = 0; i < self.visaSlideArray.count; i++) {
        [slideImages addObject:@""];
    }
    loopView.images = slideImages;
    
    [self getImage];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    //    images = @[@"zoro.jpg",@"three.jpg"];
    
    loopView = [[WMLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.8) images:slideImages autoPlay:YES delay:2.0];
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
}

static NSString * cellIdentifier = @"PP2CollectionViewCell";

- (void)initCollectionView {
    
    // 创建并设置流布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 列与列(水平卷动)/行与行(垂直卷动)之间的最小距离
    flowLayout.minimumLineSpacing = 1;
    // 两个连续的cell之间的最小距离
    flowLayout.minimumInteritemSpacing = 1;
    // 每一个cell的大小
    flowLayout.itemSize = CGSizeMake(collectionCellWidth , collectionCellWidth);
    // 卷动的方向(默认是垂直)
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 每一个cell的margin
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 5, 20);
    
    collectionViewPlus = nil;
    
    CGRect frame = CGRectMake(0, 0 , [UIScreen mainScreen].bounds.size.width, CELL_HEIGHT - 30);
    collectionViewPlus = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionViewPlus.dataSource = self;
    
    //注册CollectionViewCell
    UINib *CollectionNib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [collectionViewPlus registerNib:CollectionNib forCellWithReuseIdentifier:cellIdentifier];
    
    collectionViewPlus.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark Actions

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return CELL_HEIGHT / 8;
            break;
        case 1:
            return CELL_HEIGHT ;
            break;
        default:
            break;
    }
    return CELL_HEIGHT;
}


#pragma mark Datasource & Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    p1VC = [[PPViewController alloc] init];
    [self showViewController:p1VC sender:self];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PP2CollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.label.text = ((VisaData *)self.visaCityArray[indexPath.row]).name;
    [cell.label setFont:[UIFont systemFontOfSize:13]];
    NSURL *imageUrl = [NSURL URLWithString:((VisaData *)self.visaCityArray[indexPath.row]).pic];
//    NSLog(@"%@",imageUrl);
    [cell.imageView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@""]];
    return cell;
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
        
        //在scrollView上添加collectionView
//        cell.backgroundColor = [UIColor yellowColor];
        [cell.contentView addSubview:collectionViewPlus];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
