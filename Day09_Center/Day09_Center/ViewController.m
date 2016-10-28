//
//  ViewController.m
//  Day09_Center
//
//  Created by tarena on 16/10/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@import CoreLocation;
@import CoreBluetooth;

@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic) UITextView *textView;
@property (nonatomic) CLLocationManager *locationMgr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_textView];
    
    _locationMgr = [CLLocationManager new];
    _locationMgr.delegate = self;
    [_locationMgr requestWhenInUseAuthorization];
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E621E1F8-C36C-495A-93FC-0C247A3E6E5F"];
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"1606"];
    
    //开始检测区域
    [_locationMgr startMonitoringForRegion:region];
    //开始定位区域
    [_locationMgr startRangingBeaconsInRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region{
    [beacons enumerateObjectsUsingBlock:^(CLBeacon * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *msg = nil;
        switch (obj.proximity) {
            case CLProximityUnknown: {
                msg = @"距离未知";
                break;
            }
            case CLProximityImmediate: {
                msg = @"距离极近(几厘米以内)";
                break;
            }
            case CLProximityNear: {
                msg = @"距离近(1米以内)";
                break;
            }
            case CLProximityFar: {
                msg = @"距离远(10米以内)";
                break;
            }
        }
        _textView.text = [NSString stringWithFormat:@"%@\n%@", msg, _textView.text];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
