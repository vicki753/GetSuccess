//
//  ZYBluetoothServer.m
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/9/5.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYBluetoothServer.h"
#import "NSTimer+ZY.h"
#import "ZYBLECentralManager.h"
#import "ZYBLEPeripheralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ZYBluetoothServer ()

@property (nonatomic, strong) ZYBLECentralManager *centralManager;

@property (nonatomic, strong) NSMutableArray<ZYBLEPeripheralManager *> *peripheralManagers;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger repeatCount;

@property (nonatomic, assign) NSTimeInterval timeout;//设置扫描时长

@end


@implementation ZYBluetoothServer

-(void)dealloc {
    if (_timer) {
        [_timer invalidate];
    }
}
- (void)startScanerWithTimeout:(NSTimeInterval)timeout success:(void(^)(id result))success failure:(void(^)(NSError *error))failure {
    self.timeout = timeout;
    [self startTimer];

    [self.centralManager scanPeripheralsWithPeripheralBlock:^(NSMutableArray *pinfos) {
        success(pinfos);
    } failureBlock:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)stopScannerSuccess:(void(^)(id result))success failure:(void(^)(NSError *error))failure {
    [self stopTimer];
    [self.centralManager cancelScanWithManagerStopBlock:^(CBCentralManager *manager) {
        success(manager);
    }];
}

- (void)connectPeriperal:(CBPeripheral *)peripheral success:(void(^)(id result))success failure:(void(^)(NSError *error))failure {
    [self stopTimer];
    __weak typeof(self) weakSelf = self;
    [self stopScannerSuccess:^(id result) {
        [weakSelf.centralManager connectToPeripheral:peripheral options:nil success:^(CBPeripheral *peripheral) {
            NSLog(@"-----connected----success %@", peripheral.services.firstObject.characteristics.firstObject );
            
        } failure:^(CBPeripheral *peripheral, NSError *error) {
            NSLog(@"-----connected----error %@", error);
        }];
    } failure:^(NSError *error) {
        
    }];
  
}



#pragma mark 时间开启和暂停关闭
// 发送验证码开启
- (void)startTimer {
    self.timer.fireDate = [NSDate distantPast]; //开启定时器
}

// 停止计时关闭
- (void)stopTimer {
    self.repeatCount = 0;
    self.timer.fireDate = [NSDate distantFuture]; //停止定时器
    [self.centralManager cancelAllPeripheralsConnection];
}

#pragma mark - Getter
-(ZYBLECentralManager *)centralManager {
    if (!_centralManager) {
        _centralManager = [[ZYBLECentralManager alloc] init];
    }
    return _centralManager;
}

-(NSMutableArray<ZYBLEPeripheralManager *> *)peripheralManagers {
    if (!_peripheralManagers) {
        _peripheralManagers = [NSMutableArray array];
    }
    return _peripheralManagers;
}

-(NSTimer *)timer {
    if (!_timer) {
        __weak typeof(self) weakSelf = self;
        _timer = [NSTimer zy_scheduledTimerWithTimeInterval:1.0 repeats:YES block:^{
            weakSelf.repeatCount ++;
            if (weakSelf.repeatCount == self.timeout) {
                [weakSelf stopTimer];
            }
        }];
    }
    return _timer;
}


@end
