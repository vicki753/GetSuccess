//
//  ViewController.m
//  BlueToothTestDemo
//
//  Created by 郑奕 on 2018/8/8.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"
#import "ZYBluetoothServer.h"
#import "ZYBLECentralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;


@property (nonatomic, strong) ZYBluetoothServer *bluetoothServer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialView];
   
}

#pragma mark - Custom Method
- (void)initialView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normalCell"];
}


#pragma mark - Delegate
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];
    if (!cell) {
        cell  =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"normalCell"];
    }
    CBPeripheral *peripheral = self.dataSource[indexPath.row];
    cell.textLabel.text = peripheral.name;
    cell.detailTextLabel.text =  peripheral.identifier.UUIDString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 连接蓝牙设备
    CBPeripheral *peripheral = self.dataSource[indexPath.row];
    // 连接
    [self.bluetoothServer connectPeriperal:peripheral success:^(id result) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Event
- (IBAction)startScanAction:(UIButton *)sender {
    [self.bluetoothServer startScanerWithTimeout:100 success:^(id result) {
        NSLog(@"startScanerWithTimeout ========== result %@", result);
        self.dataSource = result;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"startScanerWithTimeout ======== error %@", error);
    }];
    
}

- (IBAction)stopScanAction:(UIButton *)sender {
    [self.bluetoothServer stopScannerSuccess:^(id result) {
        NSLog(@"stopScanAction ========== result %@", result);
    } failure:^(NSError *error) {
        NSLog(@"stopScanAction ======== error %@", error);
    }];
}

#pragma mark - Getter
-(ZYBluetoothServer *)bluetoothServer {
    if (!_bluetoothServer) {
        _bluetoothServer = [[ZYBluetoothServer alloc] init];
    }
    return _bluetoothServer;
}


@end
