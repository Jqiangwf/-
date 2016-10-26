//
//  ViewController.m
//  demo_runtime_Category
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+JQButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(20, 20, 100, 40);
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"按钮" forState:(UIControlStateNormal)];
    btn.name = @"我是";
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)btnClicked:(UIButton *)sender{
    NSLog(@"%@",sender.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
