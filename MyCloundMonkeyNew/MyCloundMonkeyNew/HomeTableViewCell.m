//
//  HomeTableViewCell.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/20.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "AdScrollView.h"
#import "DataModel.h"
#import "AdDataModel.h"

#define screenWidth               [[UIScreen mainScreen] bounds].size.width
#define screenHeight              [[UIScreen mainScreen] bounds].size.height


@interface HomeTableViewCell (){
    AdScrollView *scrollView_;
    AdDataModel *adDataModel_;
    UIView *cellView_;
}

@end

@implementation HomeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setImages:(NSArray *)images{
    _images = images;
    
    [self.contentView addSubview:self.cellView];
}

- (UIView *)cellView{
    if (!cellView_) {
        cellView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0,screenWidth, 155)];
        [cellView_ addSubview:self.scrollView];
    }
    return cellView_;
}

#pragma mark - 构建广告滚动视图
- (AdScrollView *)scrollView{
    if (!scrollView_) {
        scrollView_ = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0,screenWidth, 155)];
//        adDataModel_ = [AdDataModel adDataModelWithImageNameAndAdTitleArray];
        //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
        scrollView_.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        scrollView_.imageNameArray = _images;
        
        scrollView_.PageControlShowStyle = UIPageControlShowStyleCenter;
        scrollView_.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        
        //        [scrollView_ setAdTitleArray:dataModel_.adTitleArray withShowStyle:AdTitleShowStyleLeft];
        scrollView_.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        
    }
    return scrollView_;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
