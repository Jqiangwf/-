//
//  ViewController.m
//  demo_声音合成
//
//  Created by tarena29 on 16/10/10.
//  Copyright © 2016年 蒋强. All rights reserved.
//

#import "ViewController.h"

@import AVFoundation;

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)goodgood:(id)sender {
    //要说的话，用什么语音说，合成
    AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:@"what is matter"];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-HK"];
    
    utt.voice = voice;
    AVSpeechSynthesizer *syn = [AVSpeechSynthesizer new];
    [syn speakUtterance:utt];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
