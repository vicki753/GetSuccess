//
//  ZYSingleTonClass.m
//  ZYSingletonDemo
//
//  Created by 郑奕 on 2018/10/15.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYSingleTonClass.h"

static ZYSingleTonClass *instance = nil;

@interface ZYSingleTonClass ()
<NSCopying>

@end

@implementation ZYSingleTonClass

+ (instancetype)fisrtSharenIncetance {
    static ZYSingleTonClass *singleTon;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = [[ZYSingleTonClass alloc] init];
    });
    return singleTon;
}



static id objc = nil;
+ (instancetype)secondSharenInstance {
  // 内部使用同步锁进行多线程安全访问
    /**
     @synchronized 可以转换为 objc_sync_enter  和objc_syn_exit
     objc_sync_enter 会根据需要给每一个传进来的对象创建一个互斥锁并lock，
     objc_syn_exit 就unlock
     
     */
    @synchronized(self) {
        if (!objc) {
            objc  = [[ZYSingleTonClass alloc] init];
        }
    }
    
    return objc;
}

+(instancetype)thirdSharenInstance {
    if (instance == nil) {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}


-(instancetype)init {
    if (self = [super init]) {
        NSLog(@"创建啦！！！");
        _count = 0;
    }
    return self;
}


+(instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

-(id)copyWithZone:(NSZone *)zone {
    return instance;
}



@end
