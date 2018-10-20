//
//  ViewController.m
//  ZYOptimizeDemo
//
//  Created by 郑奕 on 2018/10/16.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]]; // 用这个方法来给view设置为背景，可以更快的渲染不会花费很多内存，不过是小图渲染
    // 同样如果是使用的一个imageView来渲染view的背景颜色的话就需要创建一个imageView然后添加到View中了
    
    
}

- (void)getMemoryWarningNotification:(NSNotification *)notfication {
    NSLog(@"view controller 中收到应用的内存警告呢！");
}


-(void)didReceiveMemoryWarning {
    NSLog(@"viewController  memory warning");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
