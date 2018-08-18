//
//  ZYLineZoomViewController.m
//  DrawEChartDemo
//
//  Created by 郑奕 on 2018/8/17.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYLineZoomViewController.h"
#import "ZYLineChartWebView.h"

@interface ZYLineZoomViewController ()

@property (nonatomic, strong) ZYLineChartWebView *lineWebView;

@end

@implementation ZYLineZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)viewDidLayoutSubviews {
    [self initialView];
}

- (void)initialView {
    self.lineWebView = [[ZYLineChartWebView alloc] initWithFrame:self.firstlineChart.bounds];
    [self.firstlineChart addSubview:self.lineWebView];
    
}

#pragma mark - Event
- (IBAction)addDataAction:(UIButton *)sender {
    for (int i = 0 ; i < 10; i++) {
        [self.lineWebView callJavaScriptsetMoreDataWithDate:[NSString stringWithFormat:@"准备检测%d",i+1] andTemperature:12+i];
    }
   
    
}


@end
