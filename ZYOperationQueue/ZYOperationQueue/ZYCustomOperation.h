//
//  ZYCustomOperation.h
//  ZYOperationQueue
//
//  Created by 郑奕 on 2018/9/29.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCustomOperation : NSOperation
@property (nonatomic, strong) NSOperationQueue *currentQueue;

+ (instancetype)shareInstance;

@end
