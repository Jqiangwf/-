//
//  JQClientViewController.m
//  demo_Sockect
//
//  Created by Apple on 2016/10/28.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "JQClientViewController.h"
#import "CocoaAsyncSocket.h"

@interface JQClientViewController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
//当前客户端
@property (nonatomic) GCDAsyncSocket *socket;
@end

@implementation JQClientViewController

//成功连接服务器
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    [self showMsg:@"成功连接到服务器"];
    //开始读取服务器发来的信息
    [_socket readDataWithTimeout:-1 tag:0];
}
//连接失败
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    [self showMsg:@"连接失败"];
}
//连接成功
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    //假设都是纯文本
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self showMsg:[NSString stringWithFormat:@"收到消息: %@",text]];
    //读完消息之后，制定继续
    [_socket readDataWithTimeout:-1 tag:0];
}

- (void)showMsg:(NSString *)text{
    _textView.text =[NSString stringWithFormat:@"%@ \n %@",text,_textView.text];
}
//发消息
- (IBAction)sendMsg:(id)sender {
    NSString *text = _textField.text;
    if (text.length == 0) {
        return;
    }
    //把内容发送给服务器
    [_socket writeData:[text dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [self showMsg:[NSString stringWithFormat:@"发出的消息: %@",text]];
    _textField.text = @"";
}
//连接
- (IBAction)connect:(id)sender {
    //176.130.2.68
    _socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue() socketQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    [_socket connectToHost:@"176.130.2.89" onPort:8686 error:&error];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
