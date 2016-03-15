//
//  DesCollectionView.m
//  FreeTravel
//
//  Created by Jason_zzzz on 16/3/13.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "DesCollectionView.h"

@implementation DesCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.cityArr = [NSMutableArray array];
        self.cityImageArr = [NSMutableArray array];
        self.sectionCityImage = [NSMutableArray array];
    }
    return self;
}

@end
