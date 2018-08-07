//
//  ZYNumberTest.h
//  TabBarViewController
//
//  Created by 郑奕 on 2018/7/31.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYNumberTest : NSNumber

@property (nonatomic, assign) int abc;


- (void)checkTheThings;
- (void)checkTheThingsWithParameters:(NSString *)parameters;
- (void)fatherMethodForThis;
+ (void)useClassMethod;
+ (void)fatherClassMethod;

@end
