//
//  NSTimer+ZY.h
//  iCooling
//
//  Created by 郑奕 on 2018/8/23.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (ZY)

+ (NSTimer *)zy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats selector:(SEL)selector;


+ (NSTimer *)zy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void(^)(void))block ;

@end
