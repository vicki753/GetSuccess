//
//  ZYCustomOperation.m
//  ZYOperationQueue
//
//  Created by 郑奕 on 2018/9/29.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYCustomOperation.h"

@interface ZYCustomOperation ()

@end

@implementation ZYCustomOperation

+ (instancetype)shareInstance {
    static ZYCustomOperation *customOperation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        customOperation = [[ZYCustomOperation alloc] init];
    });
    return customOperation;
}

-(instancetype)init {
    if (self = [super init]){
        self.currentQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

@end
