//
//  ZYBLECenterService.h
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/8/9.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZYBLECenterServiceStatus) {
    ZYBLECenterServiceConnecting,
    ZYBLECenterServiceConnected,
    ZYBLECenterServiceUnconnected
};

@class ZYBLEPeripheralModel ;
@class CBCharacteristic;

@interface ZYBLECenterService : NSObject

@property (nonatomic, strong) NSMutableArray *peripheralInfo;


//搜索设备信息，2秒后停止搜索
-(void)scanDevicesSuccess:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
//中央连接外部设备
-(void)connectPeripheral:(ZYBLEPeripheralModel*)peripheralModel;
//写入数据
-(void)writeData:(CBCharacteristic *)characteristic;
// 断开中央从端设备
-(void)disconnectedPeripheral;


@end
