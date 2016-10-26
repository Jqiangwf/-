//
//  Student.m
//  demo_Archive
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "Student.h"
/*
 runtime是OC的底层逻辑，可以 在程序运行的时候去读取 对象的方法和属性。并且篡改它们
 */

#import <objc/runtime.h>
@implementation Student
- (void)encodeWithCoder:(NSCoder *)aCoder{
    /*
     runtime第一个用途： 读取对象的所有成员变量名
     */
    //class_copyIvarList() 是C函数
    //参数1:要从那个类中获取属性名
    //参数2:属性名的数量，是二级指针，靠回传
    unsigned int outCount;
    Ivar *varList = class_copyIvarList(self.class, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar var = varList[i];
        //使用指定的方法 获取ivar类型中的 属性名
        const char *name = ivar_getName(var);
        NSString *pName = [NSString stringWithUTF8String:name];
        NSLog(@"%@",pName);
        id obj = [self valueForKey:pName];
        [aCoder encodeObject:obj forKey:pName];
    }
    
    
    //用完要手动释放占据的内存
    free(varList);
    /*
    //表示归档时，把_name和 key@“name”绑定起来
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeInteger:_age forKey:@"age"];
    [aCoder encodeBool:_marry forKey:@"marry"];
    [aCoder encodeObject:_skill forKey:@"skill"];
    [aCoder encodeObject:_school forKey:@"school"];
    [aCoder encodeObject:_score forKey:@"score"];
    [aCoder encodeObject:_className forKey:@"className"];
    [aCoder encodeObject:_favor forKey:@"favor"];
    */
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count;
        Ivar *varList = class_copyIvarList(self.class, &count);
        for (int i = 0; i < count; i++) {
            const char *name = ivar_getName(varList[i]);
            NSString *pName = [NSString stringWithUTF8String:name];
            id obj = [aDecoder decodeObjectForKey:pName];
            [self setValue:obj forKey:pName];
        }
        free(varList);
        
        /*
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.marry = [aDecoder decodeBoolForKey:@"marry"];
        self.skill = [aDecoder decodeObjectForKey:@"skill"];
        self.score = [aDecoder decodeObjectForKey:@"score"];
        self.school = [aDecoder decodeObjectForKey:@"school"];
        self.className = [aDecoder decodeObjectForKey:@"className"];
        self.favor = [aDecoder decodeObjectForKey:@"favor"];
        */
    }
    return self;
}
- (NSString *)description{
    return [NSString stringWithFormat:@"name:%@ age:%ld sex:%@ marry:%d skill:%@ school:%@ score:%@ className:%@ favor:%@",_name,_age,_sex,_marry,_skill,_school,_score,_className,_favor];
}
@end
