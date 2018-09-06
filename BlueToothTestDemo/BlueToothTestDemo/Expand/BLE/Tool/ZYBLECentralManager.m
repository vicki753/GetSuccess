//
//  ZYBLECentralManager.m
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/9/5.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYBLECentralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "ZYBLEConstantList.h"

@interface ZYBLECentralManager ()
<
CBCentralManagerDelegate,
CBPeripheralDelegate
>

@property (nonatomic, strong)CBCentralManager *centralManager;

// block
@property (nonatomic, copy) scanPeripheralPeripheralBlock scanPeripheralBlock;
@property (nonatomic, copy) scanPeripheralErrorBlock scanFailureBlock;

// successBlockNarray
@property (nonatomic, strong) NSMutableDictionary *successPeripheralBlock;
@property (nonatomic, strong) NSMutableDictionary *failurePeripheralBlock;

@property (nonatomic, copy) NSString *serviceUUID;
@property (nonatomic, copy) NSString *notifyUUID;
@property (nonatomic, copy) NSString *writeUUID;

@end

@implementation ZYBLECentralManager

-(instancetype)init {
    if (self = [super init]) {
        
#if __IPHONE_OS_VERIOSN_MIN_REQUIRED > __IPHONE_6_0
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES],CBCentralManagerOptionShowPowerAlertKey,
                             @"zybluetoothRestore", CBCentralManagerOptionRestoreIdentifierKey,nil];
#else
        NSDictionary *options = nil;
#endif
        NSArray *backgroundModes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UIBackgroundModes"];
        if ([backgroundModes containsObject:@"bluetooth-central"]) {
            
            self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options];
        }else{            // 非后台模
            self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        }
        self.centralManager.delegate = self;
        
        pocket = [[NSMutableDictionary alloc] init];
        connectedPeripherals = [NSMutableArray array];
        discoverPeripherals = [NSMutableArray array];
        reConnectPeripherals = [NSMutableArray array];
        _successPeripheralBlock = [NSMutableDictionary dictionary];
        _failurePeripheralBlock = [NSMutableDictionary dictionary];
        
    }
    return self;
}

// 扫描peripherals
-(void)scanPeripheralsWithPeripheralBlock:(scanPeripheralPeripheralBlock)successBlock failureBlock:(scanPeripheralErrorBlock)failureBlock{
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    _scanPeripheralBlock = successBlock;
    _scanFailureBlock = failureBlock;
}
// 连接
- (void)connectToPeripheral:(CBPeripheral *)peripheral options:(NSDictionary *)options success:(void (^)(CBPeripheral *peripheral))success failure:(void(^)(CBPeripheral *peripheral,NSError *error))failure{

    [self.centralManager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,CBConnectPeripheralOptionNotifyOnNotificationKey:@YES}];

    [_successPeripheralBlock setValue:success forKey:peripheral.identifier.UUIDString];
    [_failurePeripheralBlock setValue:failure forKey:peripheral.identifier.UUIDString];

}
// 断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral success:(void (^)(CBPeripheral *peripheral))success failure:(void(^)(CBPeripheral *peripheral,NSError *error))failure{
    
    [self.centralManager cancelPeripheralConnection:peripheral];
    
    [_successPeripheralBlock setValue:success forKey:peripheral.identifier.UUIDString];
    [_failurePeripheralBlock setValue:failure forKey:peripheral.identifier.UUIDString];

}
// 断开所有连接的设备
- (void)cancelAllPeripheralsConnection{
    for (int i = 0; i < connectedPeripherals.count; i++) {
        [self.centralManager cancelPeripheralConnection:connectedPeripherals[i]];
    }
}
// 停止扫描
- (void)cancelScanWithManagerStopBlock:(centralManagerStopScanBlock)block {
    [self.centralManager stopScan];
    if (block) {
        block(self.centralManager);
    }
}

// 获取当前连接的peripherals
- (NSArray *)findConnectedPeripherals {
    return connectedPeripherals;
}

// 获取当前连接的peripheral
- (CBPeripheral *)findConnectedPeripheral:(NSString *)peripheralName{
    for (CBPeripheral *p in connectedPeripherals) {
        if ([p.name isEqualToString:peripheralName]) {
            return p;
        }
    }
    return nil;
}

// 添加断开重连接的设备
- (void)sometimes_ever:(CBPeripheral *)peripheral{
    if (![reConnectPeripherals containsObject:peripheral]) {
        [reConnectPeripherals addObject:peripheral];
    }
}

// 删除需要重连接的设备
- (void)sometimes_never:(CBPeripheral *)peripheral{
    [reConnectPeripherals removeObject:peripheral];
}

#pragma mark - Delegate
#pragma mark CBCentralManagerDelegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
        case CBManagerStateUnknown:
        {
             NSLog(@"---CBManagerStateUnknown----");
        }
            break;
        case CBManagerStateResetting:
        {
             NSLog(@"---CBManagerStateResetting----");
        }
            break;
        case CBManagerStateUnsupported:
        {
            NSLog(@"---CBManagerStateUnsupported----");
        }
            break;
        case CBManagerStateUnauthorized:
        {
             NSLog(@"---CBManagerStateUnauthorized----");
        }
            break;
        case CBManagerStatePoweredOff:
        {
             NSLog(@"---CBManagerStatePoweredOff----");
        }
            break;
        case CBManagerStatePoweredOn:
        {
               NSLog(@"---CBManagerStatePoweredOn----"); //
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        }
            break;
            
        default:
        {
            NSLog(@"---CBManagerStatePoweredNone----");
        }
            break;
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSMutableString *centralDiscoverString = [NSMutableString stringWithString:@"\n"];
    [centralDiscoverString appendString:@"======= Peripheral info :\n"];
    [centralDiscoverString appendFormat:@"======= NAME: %@\n",peripheral.name];
    [centralDiscoverString appendFormat:@"======= RSSI: %@\n",RSSI];
    if (peripheral.state == CBPeripheralStateConnected) {
        [centralDiscoverString appendString:@"======= isConnected: connected"];
    }else{
        [centralDiscoverString appendString:@"======= isConnected: disconnected"];
    }
    //kCBAdvDataServiceUUIDs。
    [centralDiscoverString appendFormat:@"======= adverisement:%@", advertisementData];
    // 把serviceUUID提取出来
    NSArray *serviceUUIDs = advertisementData[@"kCBAdvDataServiceUUIDs"];
    for (CBUUID *serviceUUID in serviceUUIDs) {
        if ([[serviceUUID.UUIDString substringToIndex:8] isEqualToString:@"0000CF66"]) {
            //  这个代表是我们的产品
            if (peripheral) {
                BOOL isInclude = NO;
                for (CBPeripheral *subPerpheral in discoverPeripherals) {
                    if ([peripheral.identifier isEqual:subPerpheral.identifier]) {
                        isInclude = YES;
                    }
                }
                if (!isInclude) {
                    [discoverPeripherals addObject:peripheral];
                    _scanPeripheralBlock([discoverPeripherals copy]);
                }
                break;
            }
        }
    }

    [centralDiscoverString appendString:@"didDiscoverPeripheral\n"];
    [centralDiscoverString appendFormat:@"uuid == >:%@",[peripheral.identifier UUIDString]];
    NSLog(@"---info == %@", centralDiscoverString);
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    if (peripheral) {
        peripheral.delegate = self;
         [connectedPeripherals addObject:peripheral]; // 连接多个设备
        kCallSuccessBackBlock block = _successPeripheralBlock[peripheral.identifier.UUIDString];
        if (block) {
            block(peripheral);
            [self removeBlockKey:peripheral.identifier.UUIDString];
        }
        [peripheral discoverServices:nil];
    }
   
}

-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"didFailToConnectPeripheral ===  error %@",error);
    kCallFailureBackBlock block = _failurePeripheralBlock[peripheral.identifier.UUIDString];
    block(peripheral,error);
    [self removeBlockKey:peripheral.identifier.UUIDString];
}

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    if (error) {
        NSLog(@"didDisconnectPeripheral === %@",error);
    }
    [connectedPeripherals removeObject:peripheral];
}

#pragma mark - CBPeripheralDelegate
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSString *UUID = [peripheral.identifier UUIDString];
    if (error) {
        NSLog(@"error");
        return;
    }
    CBUUID *cbUUID = [CBUUID UUIDWithString:UUID];
    NSLog(@"cbUUID  === %@", cbUUID);
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
      
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error {
      NSLog(@"didDiscoverIncludedServicesForService  peripheral for %@ service  %@ error %@", peripheral, service, error);
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"error Discovered DescriptorsForCharacteristic for %@ with error: %@", characteristic.UUID, [error localizedDescription]);
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
     NSLog(@"didDiscoverCharacteristicsForService peripheral %@ for Service  %@ with error: %@", peripheral,service,error);
    self.serviceUUID = service.UUID.UUIDString;
    for (CBCharacteristic *characteristic  in service.characteristics) {
        if ([[characteristic.UUID.UUIDString substringToIndex:8] isEqualToString:ZYBLENotifyUUID]) {
            self.notifyUUID = characteristic.UUID.UUIDString;
        }
        
        if ([[characteristic.UUID.UUIDString substringToIndex:8] isEqualToString:ZYBLEWirteUUID]) {
            self.writeUUID = characteristic.UUID.UUIDString;
        }
    }
    
     NSLog(@"didDiscoverCharacteristicsForService self.serviceUUID %@ self.notifyUUID  %@  self.writeUUID %@", self.serviceUUID,self.notifyUUID,self.writeUUID);
}

-(void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices {
     NSLog(@"didModifyServices for %@ ", invalidatedServices);
}

-(void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {
     NSLog(@" peripheral for %@ didReadRSSI  %@ error %@", peripheral, RSSI, error);
}

-(void)peripheral:(CBPeripheral *)peripheral didOpenL2CAPChannel:(CBL2CAPChannel *)channel error:(NSError *)error {
    NSLog(@"didOpenL2CAPChannel peripheral for %@ channel %@ error %@", peripheral, channel, error);
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    NSLog(@"didWriteValueForDescriptor peripheral for %@ descriptor %@ error %@", peripheral, descriptor, error);
}

#pragma mark - Custom Method
- (void)removeBlockKey:(NSString *)key {
    [_successPeripheralBlock removeObjectForKey:key];
    [_failurePeripheralBlock removeObjectForKey:key];
}

@end
