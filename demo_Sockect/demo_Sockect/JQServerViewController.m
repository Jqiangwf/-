//
//  JQServerViewController.m
//  demo_Sockect
//
//  Created by Apple on 2016/10/28.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "JQServerViewController.h"
#import "CocoaAsyncSocket.h"



@interface JQServerViewController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

//服务器端
@property (nonatomic) GCDAsyncSocket *serverSocket;
//联入的客户端
@property (nonatomic) GCDAsyncSocket *clientSocket;
@end

@implementation JQServerViewController
- (void)showMsg:(NSString *)text{
    _textView.text =[NSString stringWithFormat:@"%@ \n %@",text,_textView.text];
}
//新的客户端联入
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    [self showMsg:@"有新的客户端连入"];
    _clientSocket = newSocket;
    //开始读取从新客户端发送的信息
    //参数1 超时时间 -1表示没有时间
    //参数2 人为设定，假设100代表图片 200代表文字。。。
    [_clientSocket readDataWithTimeout:-1 tag:0];
    
}
// 客户端连入失败
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    [self showMsg:err.description];
}
//收到对方发来的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    //假设都是纯文本
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self showMsg:[NSString stringWithFormat:@"收到消息: %@",text]];
    //读完消息之后，指定继续
    [_clientSocket readDataWithTimeout:-1 tag:0];
}


//发消息
- (IBAction)senderMsg:(id)sender {
    if (!_clientSocket) {
        return;
    }
    NSString *text = _textField.text;
    if (text.length == 0) {
        return;
    }
    [_clientSocket writeData:[text dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [self showMsg:[NSString stringWithFormat:@"发出的消息: %@",text]];
    _textField.text = @"";
    
}
//启动服务器
- (IBAction)startServer:(id)sender {
    _serverSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue() socketQueue:dispatch_get_main_queue()];
    //让服务器开放一个端口，用来接收客户端的操作
    NSError *error = nil;
    [_serverSocket acceptOnPort:8686 error:&error];
    NSLog(@"%@",error ? error : @"服务器启动成功");
    if (error) {
        [self showMsg:error.description];
    }else{
        [self showMsg:@"服务器启动成功"];
    }
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
