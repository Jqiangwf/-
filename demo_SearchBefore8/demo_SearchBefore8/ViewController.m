//
//  ViewController.m
//  demo_SearchBefore8
//
//  Created by Apple on 2016/10/28.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSMutableArray *names;
//保存结果
@property (nonatomic) NSMutableArray *searchResults;
@end

@implementation ViewController

//当搜索栏内容变化时
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self.searchResults removeAllObjects];
    [_names enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj containsString:searchString]) {
            [self.searchResults addObject:obj];
        }
    }];
    //返回值表示是否刷新搜索结果表
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //搜索控制器自带一个用于显示搜索结果的tableView 这个表默认没有注册cell
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchCell"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.names.count;
    }
    return self.searchResults.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = self.names[indexPath.row];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
        cell.textLabel.text = self.searchResults[indexPath.row];
        return cell;
    }
    
}
- (NSMutableArray *)names{
    if (!_names) {
        _names = [@[@"Nick", @"Mike",@"Bill" ,@"Jason" , @"Marry", @"Jack", @"Jerry", @"Jane", @"Tom", @"Davie", @"Bob", @"Rose", @"qingjiao",@"Neo"] mutableCopy];
    }
    return _names;
}
- (NSMutableArray *)searchResults{
    if (!_searchResults) {
        _searchResults = [NSMutableArray array];
    }
    return _searchResults;
}
@end
