//
//  ZYBLEPeripheralManager.h
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/8/12.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ZYBLEPeripheralManager : NSObject <CBPeripheralManagerDelegate>


/**
 添加服务
 */
- (void)addService;


/**
 添加广播包数据
 */
- (void)addManuFacturerData;

/**
 移除广播包数据
 */
- (void)removeAllServices;

/**
启动广播
 */
- (void)startAdvertising;

/**
 停止广播
 */
- (void)stopAdvertising;



@end
