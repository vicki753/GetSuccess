//
//  ViewController.m
//  DrawEChartDemo
//
//  Created by 郑奕 on 2018/8/17.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"
#import "ZYLineZoomViewController.h"
#import "ZYZoomDailChartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)lineChartAction:(UIButton *)sender {
    ZYLineZoomViewController *lineZoomVC = [[ZYLineZoomViewController alloc] init];
    [self.navigationController pushViewController:lineZoomVC animated:YES];
}
- (IBAction)dailChartAction:(UIButton *)sender {
    ZYZoomDailChartViewController *lineZoomVC = [[ZYZoomDailChartViewController alloc] init];
    [self.navigationController pushViewController:lineZoomVC animated:YES];
}

@end
