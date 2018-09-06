//
//  ZYBLECentralManager.h
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/9/5.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class CBPeripheral;
@class CBCentralManager;
typedef void(^kCallSuccessBackBlock)(id);
typedef void(^kCallFailureBackBlock)(id peripheral,NSError*error);
typedef void (^centralBluetoothFunctionStateBlock)(NSInteger state);
typedef void(^scanPeripheralPeripheralBlock)(NSMutableArray *pinfos);
typedef void(^scanPeripheralErrorBlock)(NSError *error);
typedef void(^centralManagerStopScanBlock)(CBCentralManager *manager);

@interface ZYBLECentralManager : NSObject
{
    @public
    BOOL needScanForPerioherals;// 是否扫描peripherals
    BOOL needConnectPeripheral; // 是否连接peripherals
    BOOL needDiscoverServices; // 是否发现services
    BOOL needDiscoverCheracteristics; // 是否获取characteristics
    BOOL needReadValueForCharacteristic; // 是否获取（更新）characteristics的值
    BOOL needDiscoverDescriptorsForCharacteristic; // 是否获取Characteristics 的描述
    BOOL needReadValueForDescrotors; // 是否获取Descriptors 的值
    
    
    // 一次处理
    BOOL oneReadValueForDescriptors;
    
    NSTimeInterval executeTime;
    NSTimer *connectTimer;
    
    NSMutableDictionary *pocket;
    
    
    @private
    // 已经连接的设备
    NSMutableArray *connectedPeripherals;
    // 发现的设备
    NSMutableArray *discoverPeripherals;
    //需要自动重连的外设
    NSMutableArray *reConnectPeripherals;
}

@property (nonatomic, copy) centralBluetoothFunctionStateBlock stateBlock;

// 扫描peripherals
-(void)scanPeripheralsWithPeripheralBlock:(scanPeripheralPeripheralBlock)successBlock failureBlock:(scanPeripheralErrorBlock)failureBlock;
// 连接
- (void)connectToPeripheral:(CBPeripheral *)peripheral options:(NSDictionary *)options success:(void (^)(CBPeripheral *peripheral))success failure:(void(^)(CBPeripheral *peripheral,NSError *error))failure;
// 断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral success:(void (^)(CBPeripheral *peripheral))success failure:(void(^)(CBPeripheral *peripheral,NSError *error))failure;
// 断开所有连接的设备
- (void)cancelAllPeripheralsConnection;
// 停止扫描
- (void)cancelScanWithManagerStopBlock:(centralManagerStopScanBlock)block;
// 获取当前连接的peripherals
- (NSArray *)findConnectedPeripherals;
// 获取当前连接的peripheral
- (CBPeripheral *)findConnectedPeripheral:(NSString *)peripheralName;
// 添加断开重连接的设备
- (void)sometimes_ever:(CBPeripheral *)peripheral;
// 删除需要重连接的设备
- (void)sometimes_never:(CBPeripheral *)peripheral;

@end
