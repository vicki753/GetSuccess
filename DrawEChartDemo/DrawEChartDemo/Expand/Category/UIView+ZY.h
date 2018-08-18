//
//  UIView+ZY.h
//  iCooling
//
//  Created by 郑奕 on 2018/8/14.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZY)

@property (nonatomic) CGFloat view_x;
@property (nonatomic) CGFloat view_y;
@property (nonatomic) CGFloat view_width;
@property (nonatomic) CGFloat view_height;
@property (nonatomic) CGFloat view_centerX;
@property (nonatomic) CGFloat view_centerY;
@property (nonatomic) CGPoint view_origin;
@property (nonatomic) CGSize  view_size;
@property (nonatomic) CGFloat view_bottom;

/**
 纯view的frame
 */
+(CGRect)getFrameWithInternalSize:(CGSize)internalSize andLastFrame:(CGRect)lastFrame andMaxWidth:(CGFloat)maxWidth andOriginalX:(CGFloat)originalX andOriginalY:(CGFloat)originalY andMarginX:(CGFloat)marginX andMarginY:(CGFloat)marginY;


@end
