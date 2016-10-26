//
//  ViewController.m
//  demo_baiduMap
//
//  Created by Apple on 2016/10/22.
//  Copyright © 2016年 JiangQiang. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"


@interface ViewController ()<BMKMapViewDelegate>
@property (nonatomic)BMKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.view = _mapView;
    //地图类型
    _mapView.mapType = 1;
    //交通状况
    _mapView.trafficEnabled = YES;
    _mapView.baiduHeatMapEnabled = YES;
    
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"这里是北京";
    [_mapView addAnnotation:annotation];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
