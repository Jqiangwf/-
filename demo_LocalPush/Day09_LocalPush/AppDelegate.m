//
//  AppDelegate.m
//  Day09_LocalPush
//
//  Created by tarena on 16/10/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //任务:程序启动以后, 在5秒钟之后, 在锁屏的界面上弹出一条提示, 并且伴随声音提示. 锁屏快捷键是CMD+L
    //1.向用户申请推送许可(录音,定位, iOS10 联网,通讯录,摄像头,相册)
    //推送的许可 分版本,iOS8 之前和之后 写法不同
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //如果有新方法
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        //否则 用旧的
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    }
    
    //方法2:通过版本号来判断 @"10.0.1" -> 10.01
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if (systemVersion >= 8.0) {
        //用新方法
    }else{
        //旧方法
    }
    
    
    
    //2.启动本地推送
    UILocalNotification *noti = [UILocalNotification new];
    noti.alertBody = @"alertBody";
    noti.alertTitle = @"alertTitle";
    noti.applicationIconBadgeNumber = 99;
    //设置推送的声音, 长度小于30秒
    noti.soundName = @"videoRing.mp3";
    //fire:启动   5秒时候
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //把通知启动起来
    [application scheduleLocalNotification:noti];
    return YES;
}
//协议方法: 监听当前的本地推送消息信息
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"%@", notification);
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //应用程序被打开时,去掉桌面图标角标
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
