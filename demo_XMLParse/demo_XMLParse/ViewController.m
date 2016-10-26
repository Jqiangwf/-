//
//  ViewController.m
//  demo_XMLParse
//
//  Created by Apple on 2016/10/25.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSXMLParserDelegate>
@property (nonatomic)NSMutableArray *dataList;
@property (nonatomic)NSMutableDictionary *gameDic;
//存放数组的字典
@property (nonatomic)NSMutableDictionary *tmpDic;
//存储当前读取的Key
@property (nonatomic)NSString *currentKey;
@end

@implementation ViewController
//文件开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    _gameDic = [NSMutableDictionary new];
    _dataList = [NSMutableArray new];
}
//某个标签开始解析
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    _currentKey = elementName;
    if ([elementName isEqualToString:@"data"]) {
        _tmpDic = [NSMutableDictionary new];
    }
}
//某个值被读取时
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        return;
    }
    if ([_currentKey isEqualToString:@"error"]) {
        [_gameDic setObject:string forKey:_currentKey ?: @""];
    }
    //因为tmpDic只有在读取data标签的开始位置才能创建，所以下方判断 就表示对应的属性 一定是在data标签范围内的
    if (_tmpDic) {
        [_tmpDic setObject:string forKey:_currentKey ?: @""];
    }
}
//某个标签解析结束
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"data"]) {
        [_dataList addObject:_tmpDic];
        _tmpDic = nil;
    }
    _currentKey = nil;
}
//文件解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [_gameDic setObject:_dataList forKey:@"data"];
    NSLog(@"%@",_gameDic);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *xmlURL = [[NSBundle mainBundle] URLForResource:@"Games" withExtension:@"xml"];
    //专门解析xml格式的类
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:xmlURL];
    //设置代理
    parser.delegate = self;
    //开始解析
    [parser parse];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
