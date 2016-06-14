//
//  NSObject+BKSwizzling.m
//  BKSafeKit
//
//  Created by BestKai on 16/5/27.
//  Copyright © 2016年 BestKai. All rights reserved.
//

#import "NSObject+BKSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (BKSwizzling)

//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        NSObject *obj = [[NSObject alloc] init];
//        
//        [obj swizzleInstanceSelector:@selector(methodSignatureForSelector:) withNewSelector:@selector(BKSafe_methodSignatureForSelector:)];
//        
//        [obj swizzleInstanceSelector:@selector(forwardInvocation:) withNewSelector:@selector(BKSafe_forwardInvocation:)];
//    });
//}

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


- (NSMethodSignature *)BKSafe_methodSignatureForSelector:(SEL)aSelector {
    
    /*替换系统原来方法
     系统方法：如果返回nil 程序会Crash掉，并抛出unrecognized selector sent to instance异常信息
     如果返回 一个函数签名 系统就会创建一个NSInvocation对象并调用-forwardInvocation:方法
     */
    NSString *sel = NSStringFromSelector(aSelector);
    
    /**
     *  Type Encodings: https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
         'v':void '@':An Object ':':A method selector
     */
    if ([sel rangeOfString:@"set"].location == 0) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else {
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}


- (void)BKSafe_forwardInvocation:(NSInvocation *)anInvocation {
    
    Class cls = [anInvocation.target class];
    class_addMethod(cls, anInvocation.selector, (IMP)crashFunction, "v@:@@");
    if ([anInvocation.target respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:anInvocation.target];
    }
}

/**
 *  崩溃函数处理
 *
 *  @param self <#self description#>
 *  @param _cmd <#_cmd description#>
 *  @param ...  <#... description#>
 *
 *  @return <#return value description#>
 */
id crashFunction(id self, SEL _cmd, ...) {

    NSAssert(NO, @"%@ [%@ %@]unrecognized selector sent to instance %p",LogPrefix,[self class],NSStringFromSelector(_cmd),self);
    return nil;
}
@end
