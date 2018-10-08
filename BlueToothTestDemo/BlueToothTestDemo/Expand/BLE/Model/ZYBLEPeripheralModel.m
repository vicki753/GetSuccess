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
@dynamic serviceUUID;
@dynamic notifyUUID;
@dynamic writeUUID;

-(void)setServiceUUID:(CBUUID *)serviceUUID {
    [[NSUserDefaults standardUserDefaults] setValue:serviceUUID.UUIDString forKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"serviceUUID"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)setWriteUUID:(CBUUID *)writeUUID {
    [[NSUserDefaults standardUserDefaults] setValue:writeUUID.UUIDString forKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"writeUUID"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setNotifyUUID:(CBUUID *)notifyUUID {
    [[NSUserDefaults standardUserDefaults] setValue:notifyUUID.UUIDString forKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"notifyUUID"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(CBUUID *)serviceUUID {
    NSString *serviceUUIDString = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"serviceUUID"]];
    CBUUID *serviceUUID;
    if (serviceUUID) {
        serviceUUID = [CBUUID UUIDWithString:serviceUUIDString];
    }
    return serviceUUID;
}

-(CBUUID *)writeUUID {
    NSString *writeUUIDString = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"writeUUID"]];
    CBUUID *writeUUID;
    if (writeUUIDString) {
        writeUUID = [CBUUID UUIDWithString:writeUUIDString];
    }
    return writeUUID;
}

-(CBUUID *)notifyUUID {
    NSString *notifyUUIDString = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@-%@",[self.identifer UUIDString],@"notifyUUID"]];
    CBUUID *notifyUUID;
    if (notifyUUIDString) {
        notifyUUID  = [CBUUID UUIDWithString:notifyUUIDString];
    }
    return notifyUUID;
}

@end
