//
//  ViewController.m
//  ZYPredicateDemo
//
//  Created by 郑奕 on 2018/10/18.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arrayOne = @[@3,@4,@6];
    NSArray *arrayTwo = @[@1,@3,@5];
    
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT(SELF IN %@)",arrayOne];
    NSArray *result = [arrayTwo filteredArrayUsingPredicate:filterPredicate];
    NSLog(@"result ======= %@", result);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
