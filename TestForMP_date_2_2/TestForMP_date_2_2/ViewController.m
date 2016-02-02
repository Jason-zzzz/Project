//
//  ViewController.m
//  TestForMP_date_2_2
//
//  Created by Jason_zzzz on 16/2/2.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "ViewController.h"
#import "DXSemiViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonAction:(id)sender {
    DXSemiViewController *svController = [[DXSemiViewController alloc] init];
    [self presentViewController:svController animated:YES completion:nil];
}

@end
