//
//  ViewController.m
//  ZYOperationQueue
//
//  Created by 郑奕 on 2018/9/29.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"
#import "ZYCustomOperation.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *numbers;

@property (nonatomic, strong) NSMutableArray *mutNumbers;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

#pragma mark - Event
- (IBAction)clickButton:(UIButton *)sender {
       NSLog(@"1 currentThread === %@",[NSThread currentThread]);
    [[ZYCustomOperation shareInstance].currentQueue setMaxConcurrentOperationCount:1];
    for (int i = 0; i < self.numbers.count; i++) {
        [[ZYCustomOperation shareInstance].currentQueue addOperationWithBlock:^{
            NSLog(@"------%@",self.numbers[i]);
              NSLog(@"3 currentThread === %@",[NSThread currentThread]);
        }];
    }
    
    
    
    
    NSLog(@"2 currentThread === %@",[NSThread currentThread]);
    
   
    
//    [ZYCustomOperation shareInstance].currentQueue addOperations: waitUntilFinished:YES
    
    
    
   
}


#pragma mark - Getter

-(NSArray *)numbers {
    if(!_numbers){
        _numbers = @[@"1",@"2", @"3", @"4", @"5"];
    }
    return _numbers;
}

-(NSMutableArray *)mutNumbers {
    if(!_mutNumbers) {
        _mutNumbers = [NSMutableArray array];
        [_mutNumbers addObjectsFromArray:self.numbers];
    }
    return _mutNumbers;
}



@end
