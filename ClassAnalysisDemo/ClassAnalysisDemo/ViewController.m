//
//  ViewController.m
//  ClassAnalysisDemo
//
//  Created by 郑奕 on 2018/8/2.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"
#import "ZYNumberTestSubClass.h"
#import "ZYObjectTest.h"
#import "ZYObjectTestTwo.h"

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
    [ZYNumberTestSubClass fatherClassMethod];
    
    ZYObjectTest * objectTest = [[ZYObjectTest alloc] init];
    NSLog(@"viewController----self %p super  -super class %@",self , NSStringFromClass([super class]) );
    NSLog(@"objectTest----address %p objectTest----name %@ \n  ZYObjectTest name = %@ %p  ",objectTest,NSStringFromClass([objectTest class]), NSStringFromClass([ZYObjectTest class]),[ZYNumberTest class]);
    
    ZYObjectTestTwo *subClassTwo = [[ZYObjectTestTwo alloc] init];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
