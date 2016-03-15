//
//  CollectionViewCell.h
//  FreeTravel
//
//  Created by Admin on 16/3/7.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *chineseName;
@property (nonatomic, copy) NSString *engName;
@property (weak, nonatomic) IBOutlet UIImageView *cityImageView;

@end
