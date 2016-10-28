//
//  AppDelegate.m
//  demo_BluePeripheral
//
//  Created by Apple on 2016/10/28.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "AppDelegate.h"
@import CoreLocation;
@import CoreBluetooth;


@interface AppDelegate ()<CBPeripheralManagerDelegate>
//周边设置管理
@property (nonatomic) CBPeripheralManager *pMgr;
@end

@implementation AppDelegate
//当前蓝牙状态
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    switch (peripheral.state) {
        case CBManagerStateUnknown:{
            NSLog(@"");
            break;
        }
        case CBManagerStateResetting:{
            NSLog(@"");
            break;
        }
        case CBManagerStateUnsupported:{
            NSLog(@"");
            break;
        }
        case CBManagerStateUnauthorized:{
            NSLog(@"");
            break;
        }
        case CBManagerStatePoweredOff:{
            NSLog(@"");
            break;
        }
        case CBManagerStatePoweredOn:{
            NSLog(@"蓝牙已开启");
            NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:@"E621E1F8-C36C-495A-93FC-0C247A3E6E5F"];
            //描述当前的区域信息
            CLBeaconRegion *region = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:11 minor:10 identifier:@"1010"];
            //向外广播自身
            [_pMgr startAdvertising:[region peripheralDataWithMeasuredPower:nil]];
            break;
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //打开
    _pMgr = [[CBPeripheralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue() options:@{CBPeripheralManagerOptionShowPowerAlertKey: @YES}];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
