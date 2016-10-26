//
//  ViewController.m
//  demo_KVO
//
//  Created by Apple on 2016/10/25.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"

/*
 kvc -> Key Value Controller
 把对象当字典使用 赋值 对象 setValue:ForKey: 取值 对象 valueForKey:
 
 KVO -> key Value Obseve 键值观察
 设计模式：观察者模式
 
 可以监听某个对象中 任意某个属性的变化
 
 
 */

@interface ViewController ()
@property (nonatomic)UILabel *label;
@end

@implementation ViewController
//sl的值是自身的地址，因为static修饰了，则表示此地址唯一
static void* sl = &sl;
static void* la = &la;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISlider *slider = [[UISlider alloc]initWithFrame:(CGRectMake(20, 20, 200, 40))];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:slider];
    _label = [[UILabel alloc]initWithFrame:(CGRectMake(20, 40, 200, 200))];
    [self.view addSubview:_label];
    _label.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:30];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"0";
    
    //为slider添加一个观察者()，观察者是当前控制器，观察Value属性的变化
    [slider addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:sl];
    [_label addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew) context:la];
    
}
- (void)sliderChanged:(UISlider *)sender{
    _label.text = @(sender.value).stringValue;

}
//当前对象如果观察到了某些事情，就会执行
//输入obser
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == sl) {
        NSLog(@"%@,%@",object,change);
    }else if (context == la){
        if ([change[@"new"] floatValue] > 0.5) {
            _label.textColor = [UIColor redColor];
        }else{
            _label.textColor = [UIColor blueColor];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
