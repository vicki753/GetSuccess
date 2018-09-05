//
//  ZYBLECentralManager.m
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/9/5.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYBLECentralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ZYBLECentralManager ()
<
CBCentralManagerDelegate,
CBPeripheralDelegate
>

@property (nonatomic, strong)CBCentralManager *centralManager;

// block
@property (nonatomic, copy) scanPeripheralPeripheralBlock scanPeripheralBlock;
@property (nonatomic, copy) scanPeripheralErrorBlock scanFailureBlock;

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
    }
    return self;
}

// 扫描peripherals
-(void)scanPeripheralsWithPeripheralBlock:(scanPeripheralPeripheralBlock)block failureBlock:(scanPeripheralErrorBlock)failureBlock{
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    _scanPeripheralBlock = block;
    _scanFailureBlock = failureBlock;
}
// 连接
- (void)connectToPeripheral:(CBPeripheral *)peripheral options:(NSDictionary *)options{
    [self.centralManager connectPeripheral:peripheral options:options];
    
}
// 断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral {
    [self.centralManager cancelPeripheralConnection:peripheral];
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

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSMutableString *centralDiscoverString = [NSMutableString stringWithString:@"\n"];
    [centralDiscoverString appendString:@"======= Peripheral info :\n"];
    [centralDiscoverString appendFormat:@"======= NAME: %@\n",peripheral.name];
    if (peripheral.state == CBPeripheralStateConnected) {
        [centralDiscoverString appendString:@"======= isConnected: connected"];
    }else{
        [centralDiscoverString appendString:@"======= isConnected: disconnected"];
    }

    [centralDiscoverString appendString:@"didDiscoverPeripheral\n"];
    [centralDiscoverString appendFormat:@"uuid == >:%@",[peripheral.identifier UUIDString]];
    NSLog(@"---info == %@", centralDiscoverString);
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
    [centralDiscoverString appendFormat:@"======= adverisement:%@", advertisementData];
    [centralDiscoverString appendString:@"didDiscoverPeripheral\n"];
    [centralDiscoverString appendFormat:@"uuid == >:%@",[peripheral.identifier UUIDString]];
    NSLog(@"---info == %@", centralDiscoverString);
    
    if (peripheral) {
        [discoverPeripherals addObject:peripheral];
        _scanPeripheralBlock([discoverPeripherals copy]);
    }
    
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    if (peripheral) {
         [connectedPeripherals addObject:peripheral];
      
    }
    NSLog(@"didConnectPeripheral === peripheral %@", peripheral);
}


-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"didFailToConnectPeripheral ===  error %@",error);
}



@end
