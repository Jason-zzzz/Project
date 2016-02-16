//
//  HomeTableViewSecondCell.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/20.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "HomeTableViewSecondCell.h"
#import "CollectionViewCell.h"

#define screenWidth               [[UIScreen mainScreen] bounds].size.width
#define screenHeight              [[UIScreen mainScreen] bounds].size.height

#define globleUrlString @"http://img04.bubugao.com/1520b3e3565_bc_73d9d5e5e4e04287375fff96041c271f_126x126.png"
#define promiseUrlString @"http://img04.bubugao.com/1520b3e70fe_bc_ccdf8fe93b0fce9ea2751d19f2f1005c_126x126.png"
#define saleUrlString @"http://img04.bubugao.com/1520b3e99a5_bc_6310d0210d5017130259eea5c6626691_126x126.png"
#define serviceUrlString @"http://img04.bubugao.com/1520b3eb499_bc_abba0d6e6da5600d6e47784698dc5dc4_126x126.png"

@interface HomeTableViewSecondCell()<NSURLSessionDelegate>{
    
    __weak IBOutlet UIButton *globle;
    __weak IBOutlet UIButton *promise;
    __weak IBOutlet UIButton *sale;
    __weak IBOutlet UIButton *service;
}

@end

@implementation HomeTableViewSecondCell

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self getImage];
    }
    return self;
}

- (void)getImage{

    // 异步下载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 1.下载globle
        NSURL *globleUrl = [NSURL URLWithString:globleUrlString];
        NSData *globleData = [NSData dataWithContentsOfURL:globleUrl];
        UIImage *globleImage = [UIImage imageWithData:globleData];

        // 2.下载promise
        NSURL *promiseUrl = [NSURL URLWithString:promiseUrlString];
        NSData *promiseData = [NSData dataWithContentsOfURL:promiseUrl];
        UIImage *promiseImage = [UIImage imageWithData:promiseData];
        
        // 3.下载sale
        NSURL *saleUrl = [NSURL URLWithString:saleUrlString];
        NSData *saleData = [NSData dataWithContentsOfURL:saleUrl];
        UIImage *saleImage = [UIImage imageWithData:saleData];
        
        // 4.下载sale
        NSURL *serviceUrl = [NSURL URLWithString:serviceUrlString];
        NSData *serviceData = [NSData dataWithContentsOfURL:serviceUrl];
        UIImage *serviceImage = [UIImage imageWithData:serviceData];
        
        // 5.回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            [globle setBackgroundImage:globleImage forState:UIControlStateNormal];
            [promise setBackgroundImage:promiseImage forState:UIControlStateNormal];
            [service setBackgroundImage:serviceImage forState:UIControlStateNormal];
            [sale setBackgroundImage:saleImage forState:UIControlStateNormal];
        });
    });

    
}

@end

//
//@interface HomeTableViewSecondCell() <UICollectionViewDataSource,UICollectionViewDelegate>{
//    
//    UICollectionView *collectionView_;
//    CollectionViewCell *collectionCell_;
//    UICollectionViewFlowLayout *layoutObject_;
//    NSString *imagePath_;
//    NSArray *imageFiles_;
//}
//
//@end
//
//@implementation HomeTableViewSecondCell
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 4;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    collectionCell_ = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
//    collectionCell_.backgroundColor = [UIColor whiteColor];
//    collectionCell_.fileName = imageFiles_[indexPath.row];
//    return collectionCell_;
//}
//
//- (UICollectionView *)collectionView{
//    if (!collectionView_) {
//        [self layoutObject];
//        CGRect frame = CGRectMake(0, 0, screenWidth, 84.5);
//        collectionView_ = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layoutObject_];
//        collectionView_.backgroundColor = [UIColor whiteColor];
//    }
//    [collectionView_ registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
//    collectionView_.delegate = self;
//    collectionView_.dataSource = self;
//    return collectionView_;
//}
//
//- (UICollectionViewLayout *)layoutObject{
//    if (!layoutObject_) {
//        //获取文件路径
//        NSString *bundlePath = [NSBundle mainBundle].bundlePath;
//        //    NSLog(@"%@",bundlePath);
//        
//        //获取图片路径
//        imagePath_ = [[bundlePath stringByAppendingString:@"/collection"] copy];
////            NSLog(@"%@",imagePath_);
//        
//        //创建fileManeger
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        imageFiles_ = [fileManager subpathsAtPath:imagePath_];
////        NSLog(@"%@",imageFiles_);
//        //    NSLog(@"%@",imageFiles_);
//        
//        
//        //创建并设置流布局
//        layoutObject_ = [[UICollectionViewFlowLayout alloc] init];
//        //列与列/行与行之间的最小距离
//        layoutObject_.minimumLineSpacing = 0;
//        //两个而连续的cell之间的最小距离
//        layoutObject_.minimumInteritemSpacing = 0;
//        //每一个cell的大小
//        layoutObject_.itemSize = CGSizeMake(screenWidth / 4, 84.5);
//        //卷动的方向(默认是垂直的)
//        layoutObject_.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        //每一个cell的margin
//        layoutObject_.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
//    return layoutObject_;
//}
//
//
//
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        //cell注册
//        [self.contentView addSubview:self.collectionView];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    return self;
//}
//
//@end
