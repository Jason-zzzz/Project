//
//  HomeViewController.m
//  
//
//  Created by Jason_zzzz on 16/3/1.
//
//

#import "HomeViewController.h"
#import "MapViewController.h"

@interface HomeViewController () {
    MapViewController *mapVC_;
}

@property (weak, nonatomic) IBOutlet UIButton *clickButton_;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickButtonAction:(id)sender {
    mapVC_ = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapVC_ animated:YES];
    
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
