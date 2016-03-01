//
//  MapViewController.m
//  FreeTravel
//
//  Created by Jason_zzzz on 16/3/1.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface MapViewController ()<MAMapViewDelegate>
{
    MAMapView *mapView_;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Methods

- (void)initView {
    mapView_ = [[MAMapView alloc] init];
    
    //配置用户Key
    [MAMapServices sharedServices].apiKey = @"5768987d3b6aeddcb3c4bbd2bca3ad0d";
    
    mapView_ = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    mapView_.delegate = self;
    
    // 定位
    mapView_.showsUserLocation = YES;
    
    // 地图跟着定位移动
    [mapView_ setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
//    3D.提供隐藏label，示例代码如下：
//    mapView_.showsLabel = NO;
//    2.自V2.6.0版本，2D栅格地图支持设置地图底图语言为英文，代码如下：
//    mapView_.language = MAMapLanguageEn;
    
    [self.view addSubview:mapView_];
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
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
