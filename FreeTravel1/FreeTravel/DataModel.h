//
//  DataModel.h
//  FreeTravel
//
//  Created by Jason_zzzz on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define basicData @"http://open.qyer.com/lastminute/conf/destination?app_installtime=1456065462&client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&lat=30.65624599563414&lon=104.0673926574023&page=1&page_size=20&ra_referer=app_lastminute_list&size=375x667&track_app_channel=App%2520Store&track_app_version=1.9.3&track_device_info=iPhone7%2C2&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&track_os=ios%25209.2.1&track_user_id="
#define visa @"http://open.qyer.com/lastminute/page/visa?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&lat=30.65606123747691&track_user_id=&lon=104.0672469779581&app_installtime=1456065462&size=375x667&track_app_version=1.9.3&track_deviceid=4BB342C6-D1A3-4AE1-A585-7A16BED33C19&track_device_info=iPhone7,2&ra_referer=choiceness&track_app_channel=App%2520Store&track_os=ios%25209.2.1"

@protocol dataModelDelegate <NSObject>

@optional
- (void)finishGetVisaImage;
- (void)finishGetCityImage: (UIImage *)image andIndex: (NSIndexPath *) index;
- (void)finishGetData;
- (void)finishGetVisa;

@end

@interface DataModel : NSObject

@property (nonatomic, assign) id <dataModelDelegate> modelDelegate;
@property (nonatomic, copy) NSMutableArray * destinationState;
@property (nonatomic, strong) NSMutableArray * visaData;

+ (DataModel *)defaultObject;

// 获取json数据
- (void)getData: (NSString *) urlString;
// 获取目的地城市图片数据
- (void)getCityImagesWith: (NSIndexPath *) cityIndex andUrl: (NSString *) cityImageUrl;
// 获取签证页图片数据
- (void)getVisaImageWith: (NSString *) visaImageUrl;
@end
