//
//  ZYObjectTestTwo.m
//  ClassAnalysisDemo
//
//  Created by 郑奕 on 2018/8/5.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYObjectTestTwo.h"
#import <objc/objc.h>
#import <objc/runtime.h>



@implementation ZYObjectTestTwo

- (instancetype)init {
    if (self = [super init]) {
        
        //        Class demoClass = objc_allocateClassPair([NSObject class], "NSDemo", 0);
        //        NSLog(@"\ndemoClass is = %p  \nclassName = %@", demoClass , NSStringFromClass(demoClass));
        const char *name = object_getClassName(self);
        Class metaClass = objc_getMetaClass(name);
        NSLog(@"\nselfClass  = %p \nsuperClass address = %p \nsuperClass name = %@ \nsuper address = %p \nsuper name = %@", self,[self superclass] ,[self superclass], [super class], [super class]);
        NSLog(@"metaClass  is = %@ metaClass address is = %p", metaClass, metaClass);
        NSLog(@"\nmetaClass superClass address = %p  \nmetaClass superClassName = %@", [metaClass superclass], [metaClass superclass]);
        
        Class currentClass = [self class];
        for (int i = 0; i < 5; i++) {
            NSLog(@"Following the isa pointer %d times give %p", i, currentClass);
            currentClass = object_getClass(currentClass);
        }
        NSLog(@"NSObject's class is %p", [NSObject class]); //0x106417ea8
        NSLog(@"NSObject's object_getClass is %p", object_getClass([NSObject class]));
        const char *objectName = object_getClassName([NSObject class]);
        NSLog(@"NSObject's meta class is %p", objc_getMetaClass(objectName));
      
    }
    return self;
}
@end
