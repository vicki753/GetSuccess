//
//  ZYDailChartWebView.h
//  DrawEChartDemo
//
//  Created by 郑奕 on 2018/8/18.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDailChartWebView : UIView

@property (nonatomic, copy) NSString *jsonString;

-(void)setTempValue:(CGFloat)temperature;

@end
