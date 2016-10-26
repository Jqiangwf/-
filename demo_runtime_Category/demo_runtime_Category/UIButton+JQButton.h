//
//  UIButton+JQButton.h
//  demo_runtime_Category
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
/*
 类别：规定不能 添加存储属性，即带有set方法的属性。
 */
@interface UIButton (JQButton)
@property (nonatomic) NSString *name;
@end
