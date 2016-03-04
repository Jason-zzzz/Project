//
//  ImagetCell.m
//  FreeTravel
//
//  Created by Admin on 16/2/24.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "ImagetCell.h"

@interface ImagetCell ()

@end

@implementation ImagetCell

- (IBAction)clickAction:(id)sender {
    UIButton *btn = sender;
    NSLog(@"123");
    
    [_loginDelegate popLoginView:btn.tag];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
