//
//  secendCell.m
//  FreeTravel
//
//  Created by Admin on 16/2/23.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "secendCell.h"

@implementation secendCell

- (IBAction)clickAction:(id)sender {
    UIButton *btn = sender;
    
    [_delegate secondPop:btn.tag];
}


@end
