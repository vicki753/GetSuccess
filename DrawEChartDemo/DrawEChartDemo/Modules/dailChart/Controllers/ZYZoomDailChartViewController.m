//
//  ZYZoomDailChartViewController.m
//  DrawEChartDemo
//
//  Created by 郑奕 on 2018/8/18.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYZoomDailChartViewController.h"
#import "ZYDailChartWebView.h"

@interface ZYZoomDailChartViewController ()

@property (nonatomic, strong)ZYDailChartWebView *dailChartWebView;

@end

@implementation ZYZoomDailChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidLayoutSubviews {
    [self initialView];
}

- (void)initialView {
   self.dailChartWebView = [[ZYDailChartWebView alloc] initWithFrame:self.firstDailChartView.bounds];
    [self.firstDailChartView addSubview:self.dailChartWebView];
    
}


#pragma mark - Event
- (IBAction)addDataAction:(UIButton *)sender {
    [self.dailChartWebView setTempValue:39.4];
    
}



@end
