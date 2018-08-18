//
//  UIView+ZY.m
//  iCooling
//
//  Created by 郑奕 on 2018/8/14.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "UIView+ZY.h"

@implementation UIView (ZY)
@dynamic  view_x;
@dynamic  view_y;
@dynamic  view_width;
@dynamic  view_height;
@dynamic  view_centerX;
@dynamic  view_centerY;
@dynamic  view_origin;
@dynamic  view_size;
#pragma mark - 快速获取设置UIView中Frame相关内容
-(CGFloat)view_x{
    return self.frame.origin.x;
}

-(void)setview_x:(CGFloat)view_x{
    CGRect frame = self.frame;
    frame.origin.x = view_x;
    self.frame = frame;
}

-(CGFloat)view_y{
    return self.frame.origin.y;
}

-(CGFloat)view_bottom{
    return self.view_y+self.view_height;
}

-(void)setview_y:(CGFloat)view_y{
    CGRect frame = self.frame;
    frame.origin.y = view_y;
    self.frame = frame;
}

-(CGFloat)view_width{
    return self.frame.size.width;
}

-(void)setview_width:(CGFloat)view_width{
    CGRect frame = self.frame;
    frame.size.width = view_width;
    self.frame = frame;
}

-(CGFloat)view_height{
    return self.frame.size.height;
}

-(void)setview_height:(CGFloat)view_height{
    CGRect frame = self.frame;
    frame.size.height = view_height;
    self.frame = frame;
}

-(CGFloat)view_centerX{
    return self.center.x;
}

-(void)setview_centerX:(CGFloat)view_centerX{
    self.center = CGPointMake(view_centerX, self.center.y);
}

-(CGFloat)view_centerY{
    return self.center.y;
}

-(void)setview_centerY:(CGFloat)view_centerY{
    self.center = CGPointMake(self.center.x, view_centerY);
}

-(CGPoint)view_origin{
    return self.frame.origin;
}

-(void)setview_origin:(CGPoint)view_origin {
    CGRect frame = self.frame;
    frame.origin = view_origin;
    self.frame = frame;
}

-(CGSize)view_size{
    return self.frame.size;
}

-(void)setview_size:(CGSize)view_size{
    CGRect frame = self.frame;
    frame.size = view_size;
    self.frame = frame;
}


/**
 纯view的frame
 */
+(CGRect)getFrameWithInternalSize:(CGSize)internalSize andLastFrame:(CGRect)lastFrame andMaxWidth:(CGFloat)maxWidth andOriginalX:(CGFloat)originalX andOriginalY:(CGFloat)originalY andMarginX:(CGFloat)marginX andMarginY:(CGFloat)marginY {
    //四个变量：x,y,w,h
    CGFloat  originX = 0;
    CGFloat  originY = 0;
    CGFloat  sizeWidth = internalSize.width;
    CGFloat  sizeHeight = internalSize.height;
    
    if (internalSize.width > (maxWidth - (lastFrame.origin.x + lastFrame.size.width +marginX))) { //这个是另起一行
        originY = lastFrame.origin.y+lastFrame.size.height+marginY; //b ySpace 上面的间隔
        originX = originalX;
    }else{ //在后面加上
        
        if (lastFrame.origin.x == CGRectZero.origin.x && lastFrame.origin.y == CGRectZero.origin.y && lastFrame.size.width == CGRectZero.size.width && lastFrame.size.height == CGRectZero.size.height ) {
            originX = originalX;
            originY = originalY;
        }else{
            originY = lastFrame.origin.y;
            originX = lastFrame.origin.x+lastFrame.size.width+marginX;
        }
        
    }
    return CGRectMake(originX, originY, sizeWidth, sizeHeight);
    
}

@end
