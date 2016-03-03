//
//  MapViewController.m
//  FreeTravel
//
//  Created by Jason_zzzz on 16/3/1.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface MapViewController ()<MAMapViewDelegate, AMapSearchDelegate>
{
    MAMapView *mapView_;
    AMapSearchAPI *_search;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配置用户Key
    [AMapSearchServices sharedServices].apiKey = @"cdc5a7b6966fcab4b40028dd5a3f44a7";
    [MAMapServices sharedServices].apiKey = @"cdc5a7b6966fcab4b40028dd5a3f44a7";
    
    [self initView];
    
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    request.keywords = @"方恒";
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    request.types = @"餐饮服务|生活服务";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [_search AMapPOIAroundSearch: request];
}

//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    //通过 AMapPOISearchResponse 对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld",response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
    NSString *strPoi = @"";
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    NSLog(@"Place: %@", result);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    mapView_.showsUserLocation = YES;
    mapView_.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    [mapView_ setZoomLevel:16.5 animated:YES];
}

//- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
//    MAAnnotationView *view = views[0];
//    
//    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
//    if ([view.annotation isKindOfClass:[MAUserLocation class]])
//    {
//        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
//        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
//        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
////        pre.image = [UIImage imageNamed:@"location.png"];
//        pre.lineWidth = 3;
//        pre.lineDashPattern = @[@6, @3];
//        
//        [mapView_ updateUserLocationRepresentation:pre];
//        
//        view.calloutOffset = CGPointMake(0, 0);
//    } 
//}

#pragma mark Methods

- (void)initView {
    mapView_ = [[MAMapView alloc] init];
    
    //配置用户Key
    [MAMapServices sharedServices].apiKey = @"5768987d3b6aeddcb3c4bbd2bca3ad0d";
    
    mapView_ = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64)];
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
- (IBAction)cancelAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
