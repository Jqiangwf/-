//
//  JQResultCollectionViewController.h
//  demo_searchAfter8
//
//  Created by Apple on 2016/10/28.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQResultCollectionViewController : UICollectionViewController
//公开一个属性 用于接收搜索结果
@property (nonatomic,copy) NSArray *results;
@end
