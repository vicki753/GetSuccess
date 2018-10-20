//
//  ZYSingleTonClass.h
//  ZYSingletonDemo
//
//  Created by 郑奕 on 2018/10/15.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYSingleTonClass : NSObject

@property (nonatomic, assign) NSInteger count;

+ (instancetype)fisrtSharenIncetance;

+ (instancetype)secondSharenInstance;

+(instancetype)thirdSharenInstance;

@end
