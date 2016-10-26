//
//  ViewController.m
//  demo_SQLite
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建数据库
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *sqlPath = [docPath stringByAppendingPathComponent:@"person.sqlite"];
    NSLog(@"%@",docPath);
    //参数1:文件路径 参数2: 生成的数据库对象
    sqlite3 *db = NULL;
    int ret = sqlite3_open([sqlPath cStringUsingEncoding:NSUTF8StringEncoding], &db);
    if (ret != SQLITE_OK) {
        NSLog(@"数据库创建失败%s",sqlite3_errmsg(db));
    }
    //打开某位置的数据库（如果没有自动创建）
    //在数据库里面创建表
    const char *createTable = "create table if not exists person (id_p int,LastName varchar(255),FirstName varchar(255),Address varchar(255),City varchar(255))";
    char *errmsg = NULL;
    ret = sqlite3_exec(db, createTable, NULL, NULL, &errmsg);
    if (ret != SQLITE_OK) {
        NSLog(@"创建表失败%s",errmsg);
    }
    
    //在表里创建数据
    const char *insert1 = "insert into person values (1,'陈','迪','龙岗','深圳')";
    ret = sqlite3_exec(db, insert1, NULL, NULL, &errmsg);
    if (ret != SQLITE_OK) {
        NSLog(@"插入表失败%s",errmsg);
    }
    //插入数据
    //搜索数据
    const char *select1 = "select * from person";
    sqlite3_stmt *ppStmt;
    ret = sqlite3_prepare_v2(db, select1, -1, &ppStmt, NULL);
    if (ret == SQLITE_OK) {
        //如果存在数据的话，则进行操作
        while (sqlite3_step(ppStmt) == SQLITE_ROW) {
            const unsigned char *firstName = sqlite3_column_text(ppStmt, 1);
            NSLog(@"%@",[NSString stringWithUTF8String:firstName]);
        }
        sqlite3_finalize(ppStmt);
    }
    
    
    //更新数据
    const char *update1 = "update person set FirstName = '迪迪'";
    ret = sqlite3_exec(db, update1, NULL, NULL, &errmsg);
    if (ret != SQLITE_OK) {
        NSLog(@"更新表失败%s",errmsg);
    }
    //删除数据
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
