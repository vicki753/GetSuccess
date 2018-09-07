//
//  ZYBLEPeripheralModel.m
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/8/9.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYBLEPeripheralModel.h"
#import <CoreBluetooth/CoreBluetooth.h>

@implementation ZYBLEPeripheralModel


-(void)setServiceUUID:(CBUUID *)serviceUUID {
    [[NSUserDefaults standardUserDefaults] setValue:serviceUUID forKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"serviceUUID"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setWriteUUID:(CBUUID *)writeUUID {
    [[NSUserDefaults standardUserDefaults] setValue:writeUUID forKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"writeUUID"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setNotifyUUID:(CBUUID *)notifyUUID {
    [[NSUserDefaults standardUserDefaults] setValue:notifyUUID forKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"notifyUUID"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(CBUUID *)serviceUUID {
    CBUUID *serviceUUID = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"serviceUUID"]];
    return serviceUUID;
}

-(CBUUID *)writeUUID {
    CBUUID *writeUUID = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"writeUUID"]];
    return writeUUID;
}

-(CBUUID *)notifyUUID {
    CBUUID *notifyUUID = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"notifyUUID"]];
    return notifyUUID;
}

@end
