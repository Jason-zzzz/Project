//
//  SearchViewController.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/25.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "SearchViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface SearchViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    AVCaptureSession * session;
}

@property (strong,nonatomic)AVCaptureDevice *device;
@property (strong,nonatomic)AVCaptureDeviceInput *input;
@property (strong,nonatomic)AVCaptureMetadataOutput *output;
@property (strong,nonatomic)AVCaptureSession *session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer *preview;

@end

@implementation SearchViewController

@synthesize device = device_;
@synthesize input = input_;
@synthesize output = output_;
@synthesize session = session_;
@synthesize preview = preview_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self scan];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scan{
    
    // Do any additional setup after loading the view, typically from a nib.
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
    
//    device_ = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    input_ = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
//    output_ = [[AVCaptureMetadataOutput alloc] init];
//    
//    [output_ setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    
//    session_ = [[AVCaptureSession alloc] init];
//    [session_ setSessionPreset:AVCaptureSessionPresetHigh];
//    if ([session_ canAddInput:self.input]) {
//        [session_ addInput:self.input];
//    }
//    if ([session_ canAddOutput:self.output]) {
//        [session_ addOutput:self.output];
//    }
//    // 条码类型
//    output_.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
//    
//    preview_ = [AVCaptureVideoPreviewLayer layerWithSession:session_];
//    preview_.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    preview_.frame = self.view.layer.bounds;
//    [self.view.layer insertSublayer:preview_ atIndex:0];
//    
//    // Start
//    [session_ startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    if ([metadataObjects count] > 0) {
        // 停止扫描
        [session_ stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
}

@end
