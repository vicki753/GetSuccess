//
//  ZYObjectTest.m
//  ClassAnalysisDemo
//
//  Created by 郑奕 on 2018/8/2.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYObjectTest.h"
#import <objc/objc.h>
#import <objc/runtime.h>

void selfIntro(id self, SEL _cmd);

@implementation ZYObjectTest

-(NSString *)description {
    return [super description];
}

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
       
        
        /*
        
        BOOL isOk = NO;
        
        isOk = class_addMethod(demoClass, @selector(intro),(IMP)&selfIntro, "v@:");
        isOk == YES ? nil : NSLog(@"failed on class_addIvar\n");
        objc_registerClassPair(demoClass);
        id demo = class_createInstance(demoClass, 0);
        if ([demo respondsToSelector:@selector(intro)]) {
            [demo performSelector:@selector(intro)];
        }
        /**
         * Returns the value associated with a given object for a given key.
         *
         * @param object The source object for the association.
         * @param key The key for the association.
         *
         * @return The value associated with the key \e key for \e object.
         *
         * @see objc_setAssociatedObject
         */
        /*
        objc_setAssociatedObject(demo, @selector(setAssociatedMethod:), [NSNumber numberWithFloat:0.3], OBJC_ASSOCIATION_ASSIGN);
        
        void *outValue = (void *)0x1;
        */
    }
    return self;
}

- (void)setAssociatedMethod:(CGFloat)associatedFloatValue {
    NSLog(@"=====setAssociatedMethod===== %lf", associatedFloatValue);
}

- (CGFloat)cornerRadius {
    return [(NSNumber *)objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setCornerRadius:(CGFloat)cornerRadius {
    objc_setAssociatedObject(self, @selector(cornerRadius), [NSNumber numberWithFloat:cornerRadius], OBJC_ASSOCIATION_ASSIGN);
}


void selfIntro(id self, SEL _cmd)
{
    Class isa = object_getClass(self);
//    while (1) {
//        if (isa == (self->isa)) {
//            NSLog(@"==  : %p , %@", isa, objc_getMetaClass(class_getName([isa class])) );
//            break;
//        }
//
//        NSLog(@"!= : %p , %@", isa, objc_getMetaClass(class_getName([isa class])));
//        isa = isa->isa;
//    }
    
}



@end
