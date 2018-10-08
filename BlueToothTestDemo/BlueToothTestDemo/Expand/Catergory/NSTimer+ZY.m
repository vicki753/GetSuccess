
//
//  NSTimer+ZY.m
//  iCooling
//
//  Created by 郑奕 on 2018/8/23.
//  Copyright © 2018 郑奕. All rights reserved.
//


#import "NSTimer+ZY.h"

@implementation NSTimer (ZY)


/*
 参考大神的循环引用方法 ：https://www.jianshu.com/p/11fae16ab622
 去掉timer的循环引用问题，之前也发现了，使用timer的时候没有处理。然后pop到上一个界面之后再返回过来发现，timer仍然还在运行
 */
+ (NSTimer *)zy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats selector:(SEL)selector{
    return [self scheduledTimerWithTimeInterval:interval target:self selector:selector userInfo:nil repeats:YES];
}

+ (NSTimer *)zy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void(^)(void))block {
    
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(zy_blockInvoke:) userInfo:[block copy] repeats:YES];
}

+ (void)zy_blockInvoke:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}





@end
