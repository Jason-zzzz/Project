//
//  firstCell.m
//  FreeTravel
//
//  Created by Admin on 16/2/23.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "firstCell.h"

@interface firstCell (){
    
    __weak IBOutlet UIButton *plane_;
    __weak IBOutlet UIButton *cityFun_;
    __weak IBOutlet UIButton *car_;
    __weak IBOutlet UIButton *sure_;
}

@end

@implementation firstCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {

    }
    return self;
}

- (IBAction)popPopView:(id)sender {
    UIButton *btn = sender;

    [_popDelegate popView:btn.tag];
}


@end
