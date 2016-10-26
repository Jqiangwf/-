//
//  WelcomeViewController.m
//  demo_vedioWelcome
//
//  Created by Apple on 2016/10/25.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "WelcomeViewController.h"
@import AVFoundation;
#import "ViewController.h"


@interface WelcomeViewController ()
@property (nonatomic)AVPlayer *player;
@property (nonatomic)AVPlayerLayer *playerLayer;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *mp4URL = [[NSBundle mainBundle] URLForResource:@"dyla_movie" withExtension:@"mp4"];
    _player = [AVPlayer playerWithURL:mp4URL];
    [_player play];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer addSublayer:_playerLayer];
    
    //设置视频的内容模式，保持比例充满
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    //以前的控制电池条样式的方法
    //如果同时编写了，那么需要到info中指定
    //默认听新的
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)playToEnd{
//    [UIApplication sharedApplication].keyWindow.rootViewController = [ViewController new];
    [UIView animateWithDuration:1 animations:^{
        //透明度渐变到0
        self.view.window.alpha = 0;
        //布局的三要素：frame，bounds，transform
        self.view.window.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [_playerLayer removeFromSuperlayer];
        _player = nil;
        self.view.window.hidden = YES;
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
