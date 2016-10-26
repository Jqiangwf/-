//
//  ViewController.m
//  demo_Archive
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     archive： 归档
     主要是把对象存磁盘
     对象包括 系统对象 如 NSString NSArray NSDictionary
     */
    /*
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"%@",docPath);
    //归档 字符串
    NSString *strPath = [docPath stringByAppendingPathComponent:@"str"];
    [NSKeyedArchiver archiveRootObject:@"NISB" toFile:strPath];
    //解档
    NSString *str = [NSKeyedUnarchiver unarchiveObjectWithFile:strPath];
    NSLog(@"%@",str);
    */
    /*
    NSDictionary *dic = @{@"name" : @"chen", @"sex" : @"woman", @"age" : @"22" };
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dicPath = [docPath stringByAppendingPathComponent:@"dic"];
    //归档
    [NSKeyedArchiver archiveRootObject:dic toFile:dicPath];
    NSLog(@"%@",dicPath);
    //接档
    NSDictionary *newDic = [NSKeyedUnarchiver unarchiveObjectWithFile:dicPath];
    NSLog(@"%@",newDic);
    */
    
    Student *stu = [Student new];
    stu.name = @"chenDi";
    stu.age = 22;
    stu.sex = @"women";
    stu.marry = NO;
    stu.className = @"通信工程";
    stu.school = @"贵阳学院";
    stu.favor = @"🐤炖🍄";
    stu.skill = @"捏🐤";
    stu.score = @"80";
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;

    NSString *stuPath = [docPath stringByAppendingPathComponent:@"stu"];
    [NSKeyedArchiver archiveRootObject:stu toFile:stuPath];
    NSLog(@"%@",stuPath);
    Student *stu1 = [NSKeyedUnarchiver unarchiveObjectWithFile:stuPath];
    NSLog(@"%@",stu1);
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
