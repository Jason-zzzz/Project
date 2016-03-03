//
//  HomeViewController.m
//  
//
//  Created by Jason_zzzz on 16/3/1.
//
//

#import "HomeViewController.h"
#import "MapViewController.h"
#import "PPViewController.h"

@interface HomeViewController () {
    MapViewController *mapVC_;
}

@property (weak, nonatomic) IBOutlet UIButton *clickButton_;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickButtonAction:(id)sender {
    mapVC_ = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapVC_ animated:YES];
    
}
- (IBAction)clickForPop:(id)sender {
//    PopViewController *popVC = [[PopViewController alloc] init];
    PPViewController *popVC = [[PPViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:popVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
