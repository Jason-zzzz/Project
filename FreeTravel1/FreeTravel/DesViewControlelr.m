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
#import "CollectionViewCell.h"
#import "PPViewController.h"

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
    NSMutableArray *cityImageArr;
    PPViewController *popViewController;
}

@property (strong, nonatomic) IBOutlet UIView *viewPlus;
@property (strong,nonatomic) UIScrollView *scrollView;
@end

@implementation DesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    popViewController = [[PPViewController alloc] init];
    dataModel_ = [DataModel allocWithZone:NULL];
    dataModel_.modelDelegate = self;
    
    [self initView];
    [self createCollectionView];
}

static NSInteger row = 0;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [dataModel_ getData:nil];

    // 初始化选中
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [tableViewPlus selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
//            // 延迟执行 （太明显）
//        double delayInSeconds = 0.3;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//            [tableViewPlus selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
//            isFirst = NO;
//        });
}

- (void)initView {
    
//    UIView *statusView = [[UIView alloc] init];
//    statusView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 20);
//    [self.navigationController.navigationBar addSubview:statusView];
//    statusView.backgroundColor = [UIColor colorWithRed:0.24 green:0.78 blue:0.49 alpha:1.0];
//    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DesNavImage2"]];
    
    tableViewPlus = [[UITableView alloc] initWithFrame:CGRectMake(0, TitleImageHeight, iPadWidth, [UIScreen mainScreen].bounds.size.height - 194 ) style:UITableViewStylePlain];
    
    // 去除白带
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 隐藏滚动条
    tableViewPlus.showsVerticalScrollIndicator = NO;
    tableViewPlus.delegate = self;
    tableViewPlus.dataSource = self;
    
    UIImage *titleImage = [UIImage imageNamed:@"DesNavImage"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    titleImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, TitleImageHeight);
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(0, 87, [UIScreen mainScreen].bounds.size.width, 35);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"sousuo_03"] forState:UIControlStateNormal];
    [searchButton setTitle:@"🔍搜索你想去的地方" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:0.822 green:0.867 blue:0.820 alpha:1.000] forState:UIControlStateNormal];
    [titleImageView addSubview:searchButton];
    [self.viewPlus addSubview:titleImageView];
//    self.navigationController.navigationBarHidden = YES;
    
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
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 15, 20);
    
    CGRect frame = CGRectMake(iPadWidth, TitleImageHeight, [UIScreen mainScreen].bounds.size.width - iPadWidth, [UIScreen mainScreen].bounds.size.height - 189);
    collectionViewPlus = [[DesCollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionViewPlus.backgroundColor = [UIColor colorWithWhite:0.943 alpha:1.000];
    collectionViewPlus.showsVerticalScrollIndicator = NO;
    collectionViewPlus.delegate = self;
    collectionViewPlus.dataSource = self;
    collectionViewPlus.tag = 101;
    
    //注册CollectionViewCell
    UINib *CollectionNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [collectionViewPlus registerNib:CollectionNib forCellWithReuseIdentifier:@"CollectionCell"];
    
    [self.view addSubview:collectionViewPlus];
}

- (void)setData: (NSInteger)section {
    
    [collectionViewPlus.cityArr removeAllObjects];
    
    
    if (!arr2) {
        
        arr2 = [NSMutableArray array];
        
        for (NSInteger i = 0; i < dataModel_.destinationState.count; i++ ) {
            NSArray *arr = [(NSDictionary *)dataModel_.destinationState[i] objectForKey:@"destinations"];
            NSMutableArray *cityImageUrl = [NSMutableArray array];
            NSMutableArray *cityArr = [NSMutableArray array];
            NSMutableArray *nameArr = [NSMutableArray array];
            NSMutableArray *engNameArr = [NSMutableArray array];
            for (NSDictionary *d in arr) {
                [nameArr addObject:[d objectForKey:@"name"]];
                [engNameArr addObject:[d objectForKey:@"name_en"]];
                [cityImageUrl addObject:[d objectForKey:@"pic"]];
            }
            [cityArr addObject:nameArr];
            [cityArr addObject:engNameArr];
            [cityArr addObject:cityImageUrl];
            [arr2 addObject:cityArr];
        }
    }
    
    
    if (!cityImageArr) {
        cityImageArr = [NSMutableArray array];
        for (NSInteger i = 0; i < arr2.count; i++) {
            NSArray *arr = arr2[i];
            
            NSMutableArray *arr1 = [NSMutableArray array];
            
//            arr1 = [NSMutableArray arrayWithCapacity:((NSArray *)arr[0]).count];
            for (NSInteger j = 0; j < ((NSArray *)arr[0]).count; j++) {
                [arr1 addObject:[NSNull null]];
            }
            [cityImageArr addObject:arr1];
        }
    }
    collectionViewPlus.sectionCityImage = cityImageArr[section];
    collectionViewPlus.cityArr = [NSMutableArray arrayWithArray:arr2[section]];
    
}

#pragma mark DataModelDelegate

- (void)finishGetData {
    
    [self setData:0];
    [tableViewPlus reloadData];
    [collectionViewPlus reloadData];
    
}

#pragma mark tableViewDelegate

static NSInteger sectionNum = 0;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    sectionNum = indexPath.row;
    row = indexPath.row;
    [self setData:indexPath.row];
    [collectionViewPlus reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataModel_.destinationState.count == 0) {
        return 1;
    }
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:popViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    DesCollectionView *view = (DesCollectionView *)collectionView;
    
    NSLog(@"---cell--%ld-----num------%ld", view.tag, view.cityArr.count);
    NSArray *arr = nil;
    if (view.cityArr.count > 0) {
        arr = view.cityArr[0];
    }
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"-----------cell--%ld",collectionView.tag);
    CollectionViewCell *cellPlus = nil;
    
    cellPlus = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    NSLog(@"%ld",indexPath.row);
    
    cellPlus.chineseName = collectionViewPlus.cityArr[0][indexPath.item];
    cellPlus.engName = collectionViewPlus.cityArr[1][indexPath.item];
    cellPlus.cityImageView.image =[UIImage imageNamed:@""];
    
    if ([collectionViewPlus.sectionCityImage[indexPath.item] isKindOfClass:[NSNull class]]) {
        [dataModel_ getCityImagesWith:indexPath andUrl: collectionViewPlus.cityArr[2][indexPath.item]];
    } else {
        cellPlus.cityImageView.image = collectionViewPlus.sectionCityImage [indexPath.item];
    }
    return cellPlus;
    
}

- (void)finishGetCityImage:(UIImage *)image andIndex:(NSIndexPath *)index {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UICollectionViewCell *cell = [collectionViewPlus cellForItemAtIndexPath:index];
        ((CollectionViewCell *)cell).cityImageView.image = image;
        collectionViewPlus.sectionCityImage[index.item] = image;
        cityImageArr[sectionNum] = collectionViewPlus.sectionCityImage;
    });
}

@end
