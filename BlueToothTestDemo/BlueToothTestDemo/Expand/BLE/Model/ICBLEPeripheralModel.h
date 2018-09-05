//
//  ICBLEPeripheralModel.h
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/9/5.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBPeripheral;
@interface ICBLEPeripheralModel : NSObject

@property (nonatomic, strong)CBPeripheral *peripheral;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *isConnectable;
@property (nonatomic, copy) NSString *localName;

@property (nonatomic, copy) NSString *manufactureData;
@property (nonatomic, copy) NSString *serviceUUIDS;

@property (nonatomic, copy) NSNumber *RSSI;

@end
