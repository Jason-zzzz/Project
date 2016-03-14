//
//  DesViewController.m
//  FreeTravel
//
//  Created by Admin on 16/3/7.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "DesViewController.h"
#import "DesModel.h"
#import "DesCell.h"
#import "DataModel.h"
#import "DesCollectionView.h"

//tableView宽度
#define iPadWidth 80
//collectionView宽度
#define collectionCellWidth 120
#define TitleImageHeight 145

#define w self.scrollView.frame.size.width
#define h self.scrollView.frame.size.height

@interface DesViewController ()<
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UIScrollViewDelegate,
    dataModelDelegate
>{
    DataModel *dataModel_;
    UITableView *tableViewPlus;
    DesCollectionView *collectionViewPlus;
    NSMutableArray *arr2;
}

@property (strong, nonatomic) IBOutlet UIView *viewPlus;
@property (strong,nonatomic) UIScrollView *scrollView;
@end

@implementation DesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataModel_ = [DataModel allocWithZone:NULL];
    
    [self initView];
    [self createCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 初始化选中
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [tableViewPlus selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)initView {
    
    tableViewPlus = [[UITableView alloc] initWithFrame:CGRectMake(0, TitleImageHeight, iPadWidth, [UIScreen mainScreen].bounds.size.height - 194 ) style:UITableViewStylePlain];
    
    // 去除白带
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableViewPlus.delegate = self;
    tableViewPlus.dataSource = self;
    
    UIImage *titleImage = [UIImage imageNamed:@"DesNavImage"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    titleImageView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, TitleImageHeight);
    
    [self.navigationController.navigationBar addSubview:titleImageView];
    
    //注册TableViewCell
    UINib *nib = [UINib nibWithNibName:@"DesCell" bundle:nil];
    [tableViewPlus registerNib:nib forCellReuseIdentifier:@"desCell"];
    
    [self.viewPlus addSubview:tableViewPlus];
    
    //    [self DesCollectionCell:collectionArr_];
    
}

- (void)createCollectionView {

    UICollectionViewFlowLayout *flowLayout;
    
    // 创建并设置流布局对象
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 列与列(水平卷动)/行与行(垂直卷动)之间的最小距离
    flowLayout.minimumLineSpacing = 10;
    // 两个连续的cell之间的最小距离
    flowLayout.minimumInteritemSpacing = 0;
    // 每一个cell的大小
    flowLayout.itemSize = CGSizeMake(collectionCellWidth , collectionCellWidth / 3 * 2);
    // 卷动的方向(默认是垂直)
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 每一个cell的margin
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);
    
    CGRect frame = CGRectMake(iPadWidth, TitleImageHeight, [UIScreen mainScreen].bounds.size.width - iPadWidth, [UIScreen mainScreen].bounds.size.height - 189);
    collectionViewPlus = [[DesCollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionViewPlus.delegate = self;
    collectionViewPlus.dataSource = self;
    collectionViewPlus.tag = 101;
    
    //注册CollectionViewCell
    UINib *CollectionNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [collectionViewPlus registerNib:CollectionNib forCellWithReuseIdentifier:@"CollectionCell"];
    
    [self setData:0];
    [self.view addSubview:collectionViewPlus];
}

- (void)setData: (NSInteger)section {
    
    [collectionViewPlus.cityArr removeAllObjects];
    
    if (!arr2) {
        
        arr2 = [NSMutableArray array];
        
        for (NSInteger i = 0; i < dataModel_.destinationState.count; i++ ) {
            NSArray *arr = [(NSDictionary *)dataModel_.destinationState[i] objectForKey:@"destinations"];
            NSMutableArray *arr1 = [NSMutableArray array];
            for (NSDictionary *d in arr) {
                [arr1 addObject:[d objectForKey:@"name"]];
            }
            [arr2 addObject:arr1];
        }
    }
    
    collectionViewPlus.cityArr = [NSMutableArray arrayWithArray:arr2[section]];
}

#pragma mark DataModelDelegate

- (void)finishGetData {
    
    [tableViewPlus reloadData];
}

#pragma mark tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setData:indexPath.row];
    [collectionViewPlus reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataModel_.destinationState.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DesCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"desCell" forIndexPath:indexPath];
    cell.desLabel.text = [(NSDictionary *)dataModel_.destinationState[indexPath.row] objectForKey:@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

//TableViewCell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    DesCollectionView *view = (DesCollectionView *)collectionView;
    
    NSLog(@"---cell--%ld-----num------%ld", view.tag, view.cityArr.count);
    return view.cityArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"-----------cell--%ld",collectionView.tag);
    UICollectionViewCell *cellPlus = nil;
    cellPlus = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    NSLog(@"%ld",indexPath.row);
    return cellPlus;
    
}

@end
