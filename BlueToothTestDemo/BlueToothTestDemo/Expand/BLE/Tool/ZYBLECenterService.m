//
//  ZYBLECenterService.m
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/8/9.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYBLECenterService.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "ZYBLEPeripheralModel.h"
#import "ZYBLEPeripheralManager.h"
#import "ZYBLECentralManager.h"

@interface ZYBLECenterService ()

@property (nonatomic, strong) ZYBLECentralManager *centralManager;

@property (nonatomic, strong) NSArray<ZYBLEPeripheralManager *> *peripheralManager;

@end

@implementation ZYBLECenterService



//搜索设备信息，2秒后停止搜索
-(void)scanDevicesSuccess:(void(^)(id result))success failure:(void(^)(NSError *error))failure {
    
}

//中央连接外部设备
-(void)connectPeripheral:(ZYBLEPeripheralModel*)peripheralModel {
    
}

-(void)writeData:(CBCharacteristic *)characteristic {
    
}

// 断开中央从端设备
-(void)disconnectedPeripheral {
    
}


@end
