//
//  ZYLineChartWebView.h
//  DrawEChartDemo
//
//  Created by 郑奕 on 2018/8/17.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYLineChartWebView : UIView

@property (nonatomic, copy) NSString *jsonString;

- (void)callJavaScriptsetMoreDataWithDate:(NSString *)date andTemperature:(CGFloat)temperature;

@end
