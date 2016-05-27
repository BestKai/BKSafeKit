//
//  NSObject+BKSwizzling.m
//  BKSafeKit
//
//  Created by BestKai on 16/5/27.
//  Copyright © 2016年 BestKai. All rights reserved.
//

#import "NSObject+BKSwizzling.h"
#import <objc/runtime.h>


void BKLog(const char* file, const char* func, int line, NSString* fmt, ...)
{
    va_list args; va_start(args, fmt);
    NSLog(@"%s|%s|%d|%@", file, func, line, [[NSString alloc] initWithFormat:fmt arguments:args]);
    va_end(args);
}


@implementation NSObject (BKSwizzling)


//替换对象方法
- (void)swizzleInstanceSelector:(SEL)origSelector withNewSelector:(SEL)newSelector{
    
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(self.class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(self.class, newSelector);
    
    if (class_addMethod(cls, origSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(cls, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else
    {
        method_exchangeImplementations(originalMethod,swizzledMethod);
    }
}
//替换类方法
+ (void)swizzleClassSelector:(SEL)origSelector withNewSelector:(SEL)newSelector{
    Class cls = [self class];
    
    Method originalMethod = class_getClassMethod(cls, origSelector);
    Method swizzledMethod = class_getClassMethod(cls, newSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* swizzing super class method, added if not exist */
        class_replaceMethod(metacls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
