//
//  ZYNumberTest.m
//  TabBarViewController
//
//  Created by 郑奕 on 2018/7/31.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYNumberTest.h"

static NSInteger staticIntegerA = 10;
static NSString *staticSrtringA = @"this is great";


@implementation ZYNumberTest

- (void)checkTheThings {
    //    int a = 1;
    //    int b = 2;
    //    int c = a + b;
    NSLog(@"--ZYNumberTest-- checkTheThings --");
}
- (void)checkTheThingsWithParameters:(NSString *)parameters {
    NSLog(@"--ZYNumberTest--checkTheThingsWithParameters --%@", parameters);
}

+ (void)useClassMethod {
    NSLog(@"--ZYNumberTest--userClassMethod --");
}

- (void)fatherMethodForThis{
    
}

+ (void)fatherClassMethod {
    
}
@end
