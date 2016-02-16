//
//  ProductsViewController.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/25.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "ProductsViewController.h"

@interface ProductsViewController(){
    UIButton *returnButton_;
}

@end

@implementation ProductsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view addSubview:self.returnButton];
}

- (UIButton *)returnButton{
    if (!returnButton_) {
        CGRect frame = CGRectMake(0, 0, 30, 30);
        returnButton_ = [UIButton buttonWithType:UIButtonTypeSystem];
        returnButton_.frame = frame;
        returnButton_.center = self.view.center;
        [returnButton_ setBackgroundImage:[UIImage imageNamed:@"res/cancel"] forState:UIControlStateNormal];
        [returnButton_ addTarget:self action:@selector(returnButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return returnButton_;
}

- (IBAction)returnButtonAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
