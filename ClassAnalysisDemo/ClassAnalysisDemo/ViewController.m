//
//  ViewController.m
//  ClassAnalysisDemo
//
//  Created by 郑奕 on 2018/8/2.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"
#import "ZYNumberTestSubClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZYNumberTestSubClass *subClass = [[ZYNumberTestSubClass alloc] init];
    [subClass checkTheThings];
    [subClass checkTheThingsWithParameters:@"hahahhahahah"];
    [ZYNumberTestSubClass useClassMethod];
    
    NSLog(@"----self %p super  -spuer class %@",self , NSStringFromClass([super class]) );
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
