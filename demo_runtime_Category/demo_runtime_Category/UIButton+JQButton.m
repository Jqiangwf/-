//
//  UIButton+JQButton.m
//  demo_runtime_Category
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "UIButton+JQButton.h"

@implementation UIButton (JQButton)
- (void)setName:(NSString *)name{
    //绑定参数1（对象）的参数3的值 到 参数2的key 上，这个值的内存管理方式是参数4
    //参数2：需要是一个唯一值 两种 1:static void* pp = &pp; 2:直接拿get方法的指针
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)name{
    //_cmd是当前方法的指针 （拿的是上面方法的唯一标志所绑定的值）
    return objc_getAssociatedObject(self, _cmd);
}
@end
