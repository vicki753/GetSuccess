//
//  ZYBLEPeripheralModel.h
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/8/9.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBPeripheral;
@class CBUUID;
@interface ZYBLEPeripheralModel : NSObject

@property (nonatomic, strong)CBPeripheral *peripheral;

@property (nonatomic, strong)CBUUID *identifer;

@property (nonatomic, strong)CBUUID *serviceUUID;

@property (nonatomic, strong)CBUUID *notifyUUID;

@property (nonatomic, strong)CBUUID *writeUUID;


@end
