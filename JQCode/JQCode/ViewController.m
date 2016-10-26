//
//  ViewController.m
//  JQCode
//
//  Created by Apple on 2016/10/25.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic)AVCaptureSession *session;
@property (nonatomic)AVCaptureVideoPreviewLayer *layer;
@end

@implementation ViewController
//扫描到数据后 触发
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects.firstObject;
        NSString *code = obj.stringValue;
        NSLog(@"%@",code);
        [_session stopRunning];
        [_layer removeFromSuperlayer];
        
        if([code containsString:@"http"]){
            NSURL *url = [NSURL URLWithString:code];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    //扫码的整体流程
    //1.打开摄像头
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.读取摄像头传入的数据，称为 输入流
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
        return;
    }
    //3.创建一个管道，用于连接摄像头和屏幕
    _session = [AVCaptureSession new];
    //管道的传输质量为极高
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    //4.需要一个接收管道传出数据的对象，输出流
    AVCaptureMetadataOutput *output = [AVCaptureMetadataOutput new];
    //为管道添加两端接口
    [_session addInput:input];
    [_session addOutput:output];
    
    //5.不管监听输出流中的数据，如果有二维码或者条形码 则通过代理方法通知
    
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置要监听的数据类型
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                   AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code];
    //6.输出摄像头的图像到屏幕上
    _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _layer.frame = self.view.bounds;
    _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_layer];
    
    //启动管道 开始工作
    [_session startRunning];
    */
    
    
    UIImageView *iconIV = [UIImageView new];
    [self.view addSubview:iconIV];
    iconIV.frame = CGRectMake(20, 20, 200, 200);
    
    //二维码的本质就是字符串  按照一定的规则 生成视图
    NSString *msg = @"http://www.stuzs.cn";
    //1.字符串转data
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    //2.data -> 图片
    //关键点是:CIFilter(过滤器)  coreImage (CI)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //为过滤器输入 元数据
    [filter setValue:data forKey:@"inputMessage"];
    //获取输出的结果
    CIImage *ciIMG = filter.outputImage;
    UIImage *img = [UIImage imageWithCIImage:ciIMG];
    iconIV.image = img;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
