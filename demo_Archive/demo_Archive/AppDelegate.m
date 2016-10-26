//
//  AppDelegate.m
//  demo_Archive
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    unsigned int numCount;
    Method *mList = class_copyMethodList([UIView class], &numCount);
    for (int i = 0; i < numCount; i ++) {
        SEL s = method_getName(mList[i]);
        NSLog(@"%@",NSStringFromSelector(s));
    }
    free(mList);
    
    /*
    //任务获取所有的UIView类型的属性名
    //1.获取属性名列表
    unsigned int count;
    objc_property_t *pList = class_copyPropertyList([UIView class], &count);
    
    
    //2.for循环每一个
    for (int i = 0; i < count; i ++) {
        const char *name = property_getName(pList[i]);
        //3. 从属性中 拿到属性名
        NSString *pName = [NSString stringWithUTF8String:name];
        NSLog(@"%@",pName);
    }
    */
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
