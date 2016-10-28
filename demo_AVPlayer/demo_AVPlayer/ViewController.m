//
//  ViewController.m
//  demo_AVPlayer
//
//  Created by tarena29 on 16/10/10.
//  Copyright © 2016年 蒋强. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
//必须是属性，播放是一个延时操作，指针需要保存
@property (nonatomic) AVPlayer *player;

@end

@implementation ViewController
//播放进度
- (IBAction)changeRange:(UISlider *)sender {
    float duration = CMTimeGetSeconds(_player.currentItem.duration);
    //秒数 = 参数1/参数2
    //移动到。。。
    [_player seekToTime:CMTimeMake( duration * sender.value, 1)];
}

- (IBAction)changeVolume:(UISlider *)sender {
    _player.volume = sender.value;
    
}
//调亮度
- (IBAction)changeBritness:(UISlider *)sender {
    [UIScreen mainScreen].brightness = sender.value;
}

- (IBAction)playMusic:(id)sender {
    NSURL *mp3Url = [[NSBundle mainBundle]URLForResource:@"庄心妍 - 以后的以后" withExtension:@"mp3"];
    _player = [AVPlayer playerWithURL:mp3Url];
    [_player play];
    
    
}
- (IBAction)playAndPause:(UIButton *)sender {
    //判断当前播放状态
    if (_player.timeControlStatus == AVPlayerTimeControlStatusPaused) {
        [_player play];
        [sender setTitle:@"暂停" forState:(UIControlStateNormal)];
    }else{
        [_player pause];
        [sender setTitle:@"开始" forState:(UIControlStateNormal)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(readCurrentProgress:) userInfo:nil repeats:YES];
    //音乐播放结束时，会发送全局的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(miusicPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //后台播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}
//VC消失时触发
- (void)dealloc{
    //切记 要有增有减
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//音乐结束后的方法
- (void)miusicPlayToEnd:(NSNotification *)noti{
    
    if (noti.object == _player.currentItem) {
        //单曲循环
        [_player seekToTime:(kCMTimeZero)];
        [_player play];
    }
    
}
//读取当前播放进度
- (void)readCurrentProgress:sender{
    float duration = CMTimeGetSeconds(_player.currentItem.duration);
    float currentTime = CMTimeGetSeconds(_player.currentTime);
    self.progressView.progress = currentTime / duration;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
