//
//  ViewController.m
//  demo_record
//
//  Created by Apple on 2016/10/25.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;
@interface ViewController ()<AVAudioRecorderDelegate>
@property (nonatomic)AVAudioRecorder *recorder;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //申请用户的录音许可
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.frame = CGRectMake(20, 20, 100, 40);
    [btn setTitle:@"start" forState:(UIControlStateNormal)];
    
    UIButton *stopbtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.view addSubview:stopbtn];
    stopbtn.frame = CGRectMake(20, 80, 100, 40);
    [stopbtn setTitle:@"end" forState:(UIControlStateNormal)];
    [stopbtn addTarget:self action:@selector(stopBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)stopBtnClick:(UIButton *)sender{
    [_recorder stop];
}
- (void)btnClicked:(UIButton *)sender{
    
    /*
     参数1:录音保存的地址
     2.录音的相关配置
     3.录音是否错误
     */
    //拼接地址：~/Document/当前时间戳.caf
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //时间戳 即1970年到现在的秒数
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSString *carPath = [NSString stringWithFormat:@"%@/%ld.caf",docPath,(long)timeStamp];
    //转换成cafPath
    NSURL *cafURL = [NSURL fileURLWithPath:carPath];
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    //设置录制的格式 PCM是最高品质
    [setting setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //采样频率
    [setting setObject:@(8000) forKey:AVSampleRateKey];
    //麦克风声道数
    [setting setObject:@1 forKey:AVNumberOfChannelsKey];
    //每个采样点位数  可选数值 8 16 24 32
    [setting setObject:@8 forKey:AVLinearPCMBitDepthKey];
    //是否采用浮点数采样
    [setting setObject:@YES forKey:AVLinearPCMIsFloatKey];
    
    _recorder = [[AVAudioRecorder alloc]initWithURL:cafURL settings:setting error:nil];
    _recorder.delegate = self;
    [_recorder record];
}
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"%@",recorder.url.absoluteString);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
