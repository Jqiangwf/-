//
//  ViewController.m
//  demo_FMDB
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"db1.sqlite"];
    //打开路径下的数据库
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSLog(@"%@",dbPath);
        //executeUpdate:此方法可以执行增删改
       BOOL suc = [db executeUpdate:@"create table if not exists person (id_p int ,name varchar,age int , school varchar , skill varchar)"];
        NSLog(@"%@",suc ? @"success" : [db lastError] );
        for (int i = 0; i < 10; i ++) {
//            [db executeUpdate:@"insert into person values(1,'chenDi',22,'gyu','xjj')"];
            //可以穿入参数的数据库语句
            [db executeUpdateWithFormat:@"insert into person values(1,'chenDi',%d,'gyu','xjj')",arc4random() % 60 + 10];
        }
        //查询出40 岁以上的人
        FMResultSet *res = [db executeQuery:@"select * from person where age > 40 order by age"];
        //如果存在数据
        while ([res next]) {
            int age = [res intForColumn:@"age"];
            NSString *name = [res stringForColumn:@"name"];
            NSLog(@"name %@ , age %d",name,age);
        }
        
        
    }else{
        NSLog(@"失败了");
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
