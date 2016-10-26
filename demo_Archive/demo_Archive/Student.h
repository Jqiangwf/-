//
//  Student.h
//  demo_Archive
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 对于自定义类型的归档，必须实现 NSCoding协议，并实现负责归档和接档的方法
 */
@interface Student : NSObject<NSCoding>

@property (nonatomic)NSString *name;
@property (nonatomic)NSInteger age;
@property (nonatomic)NSString *sex;
@property (nonatomic)BOOL marry;
@property (nonatomic)NSString *school;
@property (nonatomic)NSString *className;
@property (nonatomic)NSString *favor;
@property (nonatomic)NSString *skill;
@property (nonatomic)NSString *score;
@end
