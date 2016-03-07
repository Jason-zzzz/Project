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

#define API_KEY @"cdc5a7b6966fcab4b40028dd5a3f44a7"

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
    [AMapSearchServices sharedServices].apiKey = API_KEY;
    [MAMapServices sharedServices].apiKey = API_KEY;
    
    [self initView];
    [self initSearch];
    [self POIRequest];
    [self aroundSearch];
    [self drvingSearch];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    mapView_.showsUserLocation = YES;
    mapView_.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    [mapView_ setZoomLevel:16.5 animated:YES];
}

#pragma mark Methods

- (void)initView {
    
    mapView_ = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64)];
    mapView_.mapType = MAMapTypeStandard;
    mapView_.delegate = self;
    
    // 定位
    mapView_.showsUserLocation = YES;
    
    // 地图跟着定位移动
    [mapView_ setUserTrackingMode: MAUserTrackingModeFollowWithHeading animated:YES];
    
    [self.view addSubview:mapView_];
}

- (void)initSearch {
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}

// 创建POI请求
- (void)POIRequest {
    
    AMapReGeocodeSearchRequest *request1 = [[AMapReGeocodeSearchRequest alloc]init];
    //    request1.searchType = AMapNearbySearchTypeLiner;
    AMapGeoPoint *point = [[AMapGeoPoint alloc]init];
    point.latitude = 37;
    point.longitude = 100;
    request1.location = point;
    
    request1.requireExtension=YES;
    [_search AMapReGoecodeSearch:request1];
}

// 创建周边请求
- (void)aroundSearch {
    
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    request.keywords = @"北京烤鸭";
    //    request.
    //    request.types = @"餐饮服务|生活服务";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [_search AMapPOIAroundSearch: request];
}

// 路径规划
- (void)drvingSearch{
    
    //构造AMapDrivingRouteSearchRequest对象，设置驾车路径规划请求参数
    AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
    request.origin = [AMapGeoPoint locationWithLatitude:39.994949 longitude:128.447265];
    request.destination = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    request.strategy = 2;//距离优先
    request.requireExtension = YES;
    
    //发起路径搜索
    [_search AMapDrivingRouteSearch:request];
}

//实现路径搜索的回调函数
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if(response.route == nil)
    {
        return;
    }
    
    //通过AMapNavigationSearchResponse对象处理搜索结果
    NSString *route = [NSString stringWithFormat:@"Navi: %@ %ld", response.route.paths[0], response.count];
    NSLog(@"%@", route);
}

#pragma mark CallBack

// 会不断调用
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    if(updatingLocation) {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        // 取出坐标后创建地理编码请求
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc]init];
        //        request.searchType=AMapSearchType_ReGeocode;
        AMapGeoPoint *point = [[AMapGeoPoint alloc]init];
        point.latitude = userLocation.coordinate.latitude;
        point.longitude = userLocation.coordinate.longitude;
        request.location = point;
        
        request.requireExtension=YES;
        [_search AMapReGoecodeSearch:request];
    }
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
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@ %@ %@", strPoi, p.description, p.name, p.address];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    NSLog(@"Place: %@", result);
}

// 逆地理编码完成后的回调
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSLog(@"%@",response.regeocode.formattedAddress);
    //    创建大头针
    MAPointAnnotation *anno=[[MAPointAnnotation alloc]init];
    anno.coordinate=CLLocationCoordinate2DMake(31, 121);
    anno.title=response.regeocode.formattedAddress;
    
    [mapView_ removeAnnotations:mapView_.annotations];
    [mapView_ addAnnotation:anno];
}

////解析地址
//-(void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
//{
//    //    返回数据在 response.geocodes数组中
//    NSMutableArray *array=[NSMutableArray array];
//    for(AMapGeocode *code in response.geocodes)
//    {
//        //        创建大头针
//        MAPointAnnotation *anno=[[MAPointAnnotation alloc]init];
//        anno.coordinate=CLLocationCoordinate2DMake(code.location.latitude, code.location.longitude);
//        anno.title=code.formattedAddress;
//        [array addObject:anno];
//    }
//    //    删除以前的大头针
//    [mapView_ removeAnnotations:mapView_.annotations];
//    //     添加大头针
//    [mapView_ addAnnotations:array];
//}


//// 添加AnnotationViews之后
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

@end
