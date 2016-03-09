//
//  DesViewController.m
//  FreeTravel
//
//  Created by Admin on 16/3/7.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "DesViewController.h"
#import "DesModel.h"

//tableView宽度
#define iPadWidth 80
//collectionView宽度
#define collectionCellWidth 120

@interface DesViewController ()<
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    DesModelDelegate,
    UIScrollViewDelegate
>{
    NSArray *collectionArr_;
}

@property (strong, nonatomic) IBOutlet UIView *viewPlus;
@property (strong,nonatomic) UIScrollView *scrollView;
@end

@implementation DesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *tableViewPlus = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, iPadWidth, [UIScreen mainScreen].bounds.size.height - 64 ) style:UITableViewStyleGrouped];
    tableViewPlus.delegate = self;
    tableViewPlus.dataSource = self;
    
    UIImage *titleImage = [UIImage imageNamed:@"DesNavImage"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    titleImageView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 145);
    
    [self.navigationController.navigationBar addSubview:titleImageView];
    
    //注册TableViewCell
    UINib *nib = [UINib nibWithNibName:@"DesCell" bundle:nil];
    [tableViewPlus registerNib:nib forCellReuseIdentifier:@"desCell"];
    
    [self.viewPlus addSubview:tableViewPlus];

    //添加右侧的scrollView
    CGRect frame = CGRectMake(iPadWidth, 145, [UIScreen mainScreen].bounds.size.width - iPadWidth, [UIScreen mainScreen].bounds.size.height);
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.backgroundColor = [UIColor blueColor];
    _scrollView.scrollEnabled = NO; //禁止滑动时移动scrollView 防止和collectionView冲突
    [_viewPlus addSubview:_scrollView];
    
    [self DesCollectionCell:collectionArr_];
    
}

#pragma mark DesModelDelegate

- (void)DesCollectionCell:(NSArray *)CollectionArr{

    
    collectionArr_ = CollectionArr;
    
    CGFloat w = self.scrollView.frame.size.width;
    CGFloat h = self.scrollView.frame.size.height;

    // 创建并设置流布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 列与列(水平卷动)/行与行(垂直卷动)之间的最小距离
    flowLayout.minimumLineSpacing = 20;
    // 两个连续的cell之间的最小距离
    flowLayout.minimumInteritemSpacing = 20;
    // 每一个cell的大小
    flowLayout.itemSize = CGSizeMake(collectionCellWidth , collectionCellWidth / 4 * 3);
    // 卷动的方向(默认是垂直)
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 每一个cell的margin
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //背景颜色
    //todo
    UICollectionView *collectionViewPlus = nil;
    for (NSInteger i = 0; i < 5; i++) {  //todo
        CGRect frame = CGRectMake(0, 0 + i * h, [UIScreen mainScreen].bounds.size.width - iPadWidth, [UIScreen mainScreen].bounds.size.height - 189);
        collectionViewPlus = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        collectionViewPlus.delegate = self;
        collectionViewPlus.dataSource = self;
        collectionViewPlus.tag = i + 1000;
        
        //注册CollectionViewCell
        UINib *CollectionNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
        [collectionViewPlus registerNib:CollectionNib forCellWithReuseIdentifier:@"CollectionCell"];
        
        if (collectionViewPlus.tag == 1000) {
            collectionViewPlus.backgroundColor = [UIColor blueColor];
        }
        if (collectionViewPlus.tag == 1001) {
            collectionViewPlus.backgroundColor = [UIColor redColor];
        }
        if (collectionViewPlus.tag == 1002) {
            collectionViewPlus.backgroundColor = [UIColor greenColor];                     //todo
        }
        if (collectionViewPlus.tag == 1003) {
            collectionViewPlus.backgroundColor = [UIColor lightGrayColor];
        }
        if (collectionViewPlus.tag == 1004) {
            collectionViewPlus.backgroundColor = [UIColor yellowColor];
        }
        
        //在scrollView上添加collectionView
        [self.scrollView addSubview:collectionViewPlus];
    }
    //设置scrollView
    self.scrollView.contentSize = CGSizeMake(w, h * 5);//todo
}

#pragma mark UIscrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //拖动scrollView时tableViewCell跟着动
    
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"desCell" forIndexPath:indexPath];
    cell.textLabel.text = @"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中Cell 变化右边的scrollView
    CGRect frame = self.scrollView.bounds;
    frame.origin.y = frame.size.height * indexPath.row;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
//TableViewCell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cellPlus = nil;
    cellPlus = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    return cellPlus;
}

@end
