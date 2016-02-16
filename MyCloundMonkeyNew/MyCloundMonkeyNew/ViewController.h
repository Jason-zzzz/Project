//
//  ViewController.h
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/20.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHNavSliderMenu.h"

@interface ViewController : UIViewController

@property (nonatomic)QHNavSliderMenuType menuType;
@property (nonatomic, copy) NSMutableArray *arr;
@property (nonatomic) NSArray *imagesArray;

@end

