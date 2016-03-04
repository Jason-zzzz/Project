//
//  thirdCell.m
//  FreeTravel
//
//  Created by Admin on 16/2/23.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "thirdCell.h"

@implementation thirdCell

- (IBAction)thirdPop:(id)sender {
    UIButton *btn = sender;
    
    [_delegate thirdPopView:btn.tag];
}

@end
