//
//  PPfirstCell.m
//  FreeTravel
//
//  Created by Admin on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "PPfirstCell.h"

#define CELL_HEIGHT 370
#define collectionCellWidth 100

@interface PPfirstCell () <UICollectionViewDataSource> {
}

@end

@implementation PPfirstCell

static NSString * cellIdentifier = @"PP2CollectionViewCell";

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
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
    
    UICollectionView *collectionViewPlus = nil;

    CGRect frame = CGRectMake(0, 10 , [UIScreen mainScreen].bounds.size.width, CELL_HEIGHT - 10);
    collectionViewPlus = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionViewPlus.dataSource = self;
    
    //注册CollectionViewCell
    UINib *CollectionNib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [collectionViewPlus registerNib:CollectionNib forCellWithReuseIdentifier:cellIdentifier];
    
    collectionViewPlus.backgroundColor = [UIColor blueColor];
    
    //在scrollView上添加collectionView
    [self.contentView addSubview:collectionViewPlus];

}


#pragma mark Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;// = [collectionView dequeueReusableCellWithReuseIdentifier:@"123" forIndexPath:indexPath];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];

    return cell;
}

@end
