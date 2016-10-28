//
//  ViewController.m
//  demo_searchAfter8
//
//  Created by Apple on 2016/10/28.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"
#import "JQResultCollectionViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *names;

//iOS8之后的搜索控制器：优点可以自定义搜索结果展示的样式
@property (nonatomic) UISearchController *searchController;
@end

@implementation ViewController
//搜索栏内容变化时
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //从搜索栏UI中获取当前的搜索文本
    NSString *searchString = searchController.searchBar.text;
    NSMutableArray *results = [NSMutableArray array];
    [_names enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj containsString:searchString]) {
            [results addObject:obj];
        }
    }];
    //把搜索结果传入对应的结果控制器中
    JQResultCollectionViewController *vc = (JQResultCollectionViewController *)searchController.searchResultsController;
    vc.results = results;
    [vc.collectionView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    JQResultCollectionViewController *vc = [[JQResultCollectionViewController alloc]initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    _searchController = [[UISearchController alloc]initWithSearchResultsController:vc];
    //设置代理，搜索内容变化时的处理方式
    _searchController.searchResultsUpdater = self;
    //让搜索控制器自带的搜索栏UI 作为表格的头部
    self.tableView.tableHeaderView = _searchController.searchBar;
    //是否允许切换到搜索结果控制器
    self.definesPresentationContext = YES;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.names.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.names[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)names{
    if (!_names) {
        _names = [@[@"Nick", @"Mike",@"Bill" ,@"Jason" , @"Marry", @"Jack", @"Jerry", @"Jane", @"Tom", @"Davie", @"Bob", @"Rose", @"qingjiao",@"Neo"] mutableCopy];
    }
    return _names;
}


@end
