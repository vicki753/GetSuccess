//
//  ZYLineChartWebView.m
//  DrawEChartDemo
//
//  Created by 郑奕 on 2018/8/17.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYLineChartWebView.h"
#import <WebKit/WebKit.h>

@interface ZYLineChartWebView ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation ZYLineChartWebView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialView];
    }
    return self;
}

- (void)initialView {

    NSBundle *echartsBundle = [NSBundle mainBundle];
    NSString *urlString = [echartsBundle pathForResource:@"ICLineTemperatureChart" ofType:@"html"];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *loadRequest = [[NSURLRequest alloc] initWithURL:url];

    self.webView = [[UIWebView alloc] initWithFrame:self.bounds];
//    self.secondWebView.multipleTouchEnabled = NO;
//    self.secondWebView.userInteractionEnabled = NO;
    self.webView.delegate = self;
    [self addSubview:self.webView];
    [self.webView loadRequest:loadRequest];
    
}

//- (void)requestData {
//    NSDictionary *response = @{};
//    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)response];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:mutDic options:NSJSONWritingPrettyPrinted error:nil];
//    self.jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//}

- (void)callJavaScriptsetMoreDataWithDate:(NSString *)date andTemperature:(CGFloat)temperature {
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"data.push(setNewValue('%@',%lf))",date,temperature]];
      [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"myChart.setOption(lineChartOption());"]];
}


#pragma mark - Delegate
#pragma mark UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
   
}


@end
