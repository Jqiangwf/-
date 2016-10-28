//
//  ViewController.m
//  demo_Lrc
//
//  Created by tarena29 on 16/10/12.
//  Copyright © 2016年 蒋强. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;
@interface ViewController ()
//保存有效的歌词
@property (nonatomic) NSMutableArray *lyricArray;
//保存秒数
@property (nonatomic) NSMutableArray *secondArray;

@property (nonatomic) AVPlayer *player;
@end

@implementation ViewController
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lyricArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _lyricArray[indexPath.row];
    //设置文字高粱颜色
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    //去掉选中的背景色
    cell.selectedBackgroundView = [UIView new];

    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *lrcPath = [[NSBundle mainBundle] pathForResource:@"郁可唯-青衣谣" ofType:@"lrc"];
    NSString *lrcStr = [NSString stringWithContentsOfFile:lrcPath encoding:(NSUTF8StringEncoding) error:nil];
    lrcStr = [lrcStr componentsSeparatedByString:@"[00:00.00]\n"].lastObject;//（歌词前面内容）
    lrcStr = [lrcStr componentsSeparatedByString:@"]\n"].firstObject;//（歌词后面广告）
    NSMutableArray *tmpArr = [[lrcStr componentsSeparatedByString:@"\n"] mutableCopy];
    [tmpArr removeLastObject];//删除最后一个元素(广告)
    self.secondArray = [NSMutableArray array];
    [tmpArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.lyricArray addObject:[(NSString *)obj componentsSeparatedByString:@"]"].lastObject];
        //截取时间字符串
        NSString *time = [[obj componentsSeparatedByString:@"]"].firstObject componentsSeparatedByString:@"["].lastObject;
        //截取分钟
        NSString *mTime = [time componentsSeparatedByString:@":"].firstObject;
        //截取秒
        NSString *sTime = [[time componentsSeparatedByString:@":"].lastObject componentsSeparatedByString:@"."].firstObject;
        //截取毫秒
        NSString *msTime = [time componentsSeparatedByString:@"."].lastObject;
        //把时间转为秒数 1:60:1000
        float second = [mTime floatValue] * 60 + [sTime floatValue] + [msTime floatValue] / 1000;
        [_secondArray addObject:[NSString stringWithFormat:@"%.3f",second]];
    }];
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"青衣谣" withExtension:@"mp3"];
    _player = [AVPlayer playerWithURL:url];
    [_player play];
    [NSTimer scheduledTimerWithTimeInterval:0.00001 repeats:YES block:^(NSTimer * _Nonnull timer) {
        float currentTime = CMTimeGetSeconds(_player.currentTime);
        //当前时间取3位小数，精度不能过高
        NSString *timeStr = [NSString stringWithFormat:@"%.3f",currentTime];
        if([_secondArray containsObject:timeStr]){
            //获取时间对应的索引值
            NSInteger row = [_secondArray indexOfObject:timeStr];
            //手动滚动到
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_player seekToTime:CMTimeMake([self.secondArray[indexPath.row] integerValue], 1)] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSMutableArray *)lyricArray {
	if(_lyricArray == nil) {
		_lyricArray = [[NSMutableArray alloc] init];
	}
	return _lyricArray;
}

@end
