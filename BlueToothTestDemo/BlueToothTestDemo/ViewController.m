//
//  ViewController.m
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/8/8.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"
#import "ZYBluetoothServer.h"
#import "ZYBLECentralManager.h"

@interface ViewController ()

@property (nonatomic, strong) ZYBluetoothServer *bluetoothServer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark - Event

- (IBAction)startScanAction:(UIButton *)sender {
    [self.bluetoothServer startScanerWithTimeout:100 success:^(id result) {
        NSLog(@"startScanerWithTimeout ========== result %@", result);
    } failure:^(NSError *error) {
        NSLog(@"startScanerWithTimeout ======== error %@", error);
    }];
    
}

- (IBAction)stopScanAction:(UIButton *)sender {
    
}

#pragma mark - Getter
-(ZYBluetoothServer *)bluetoothServer {
    if (!_bluetoothServer) {
        _bluetoothServer = [[ZYBluetoothServer alloc] init];
    }
    return _bluetoothServer;
}


@end
