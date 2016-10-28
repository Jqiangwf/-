//
//  ViewController.m
//  demo_BlueComunicate
//
//  Created by Apple on 2016/10/28.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"
//蓝牙通讯类库
@import MultipeerConnectivity;

@interface ViewController ()<MCBrowserViewControllerDelegate,MCSessionDelegate,MCAdvertiserAssistantDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) MCPeerID *otherPID;

//广播自身
@property (nonatomic) MCAdvertiserAssistant *advertise;
//描述自身
@property (nonatomic) MCSession *session;
@end

@implementation ViewController
- (IBAction)senderMsg:(id)sender {
    NSString *text = _textField.text;
    if (text.length == 0) {
        NSLog(@"请输入内容");
        return;
    }
    if (_otherPID == nil) {
        NSLog(@"当前无聊天对象");
        return;
    }
    NSError *error = nil;
    [_session sendData:[text dataUsingEncoding:NSUTF8StringEncoding] toPeers:@[_otherPID] withMode:MCSessionSendDataUnreliable error:&error];
    NSLog(@"%@",error ? @"发送失败" : @"发送成功" );
    if (!error) {
        _textField.text = @"";
        [self showMsg:[NSString stringWithFormat:@"%@: %@",_session.myPeerID.displayName,text]];
    }
    
    
}
//搜索设备
- (IBAction)startAdvertise:(id)sender {
    MCBrowserViewController *vc = [[MCBrowserViewController alloc]initWithServiceType:@"1606A" session:self.session];
    [self presentViewController:vc animated:YES completion:nil];
    vc.delegate = self;
}
-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self showMsg:[NSString stringWithFormat:@"%@: %@",peerID,text]];
}

//配对
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    switch (state) {
        case MCSessionStateConnected:{
            self.title = @"已经连接";
            _otherPID = peerID;
            break;
        }
        case MCSessionStateNotConnected:{
            self.title = @"没有连接";
            _otherPID = nil;
            break;
        }
        case MCSessionStateConnecting:{
            self.title = @"正在连接";
            break;
        }
        default:
            break;
    }
    [self showMsg:[NSString stringWithFormat:@"与 %@ %@",peerID,self.title]];
    
}
- (void)showMsg:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        _textView.text = [NSString stringWithFormat:@"%@\n%@",msg,_textView.text];
    });
}


//打开天线
- (IBAction)searchDevice:(id)sender {
    _advertise = [[MCAdvertiserAssistant alloc]initWithServiceType:@"1606A" discoveryInfo:nil session:self.session];
    _advertise.delegate = self;
    //开始广播
    [_advertise start];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MCSession *)session{
    if (!_session) {
        MCPeerID *peer = [[MCPeerID alloc]initWithDisplayName:@"GoodBoy"];
        _session = [[MCSession alloc]initWithPeer:peer];
        _session.delegate = self;
    }
    return _session;
}
@end
