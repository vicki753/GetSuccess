//
//  ZYBluetoothServer.h
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/9/5.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBPeripheral;
@interface ZYBluetoothServer : NSObject

- (void)startScanerWithTimeout:(NSTimeInterval)timeout success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

- (void)stopScannerSuccess:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

- (void)connectPeriperal:(CBPeripheral *)peripheral success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

@end
