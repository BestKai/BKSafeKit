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
//        [self hookMethedClass:self.class hookSEL:@selector(methodSignatureForSelector:) originalSEL:@selector(methodSignatureForSelectorOriginal:) myselfSEL:@selector(BKSafe_methodSignatureForSelector:)];
//        
//        [self hookMethedClass:self.class hookSEL:@selector(forwardInvocation:) originalSEL:@selector(forwardInvocationOriginal:) myselfSEL:@selector(BKSafe_forwardInvocation:)];
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

//+ (void)hookMethedClass:(Class)class hookSEL:(SEL)hookSEL originalSEL:(SEL)originalSEL myselfSEL:(SEL)mySelfSEL
//{
//    Method hookMethod = class_getInstanceMethod(class, hookSEL);
//    Method mySelfMethod = class_getInstanceMethod(self, mySelfSEL);
//    
//    IMP hookMethodIMP = method_getImplementation(hookMethod);
//    class_addMethod(class, originalSEL, hookMethodIMP, method_getTypeEncoding(hookMethod));
//    
//    IMP hookMethodMySelfIMP = method_getImplementation(mySelfMethod);
//    class_replaceMethod(class, hookSEL, hookMethodMySelfIMP, method_getTypeEncoding(hookMethod));
//}
//
//
//- (NSMethodSignature *)BKSafe_methodSignatureForSelector:(SEL)aSelector {
//    
//    /*替换系统原来方法
//      
//     系统方法：如果返回nil 程序会Crash掉，并抛出unrecognized selector sent to instance异常信息
//     
//     如果返回 一个函数签名 系统就会创建一个NSInvocation对象并调用-forwardInvocation:方法
//     */
//    NSString *sel = NSStringFromSelector(aSelector);
//    if ([sel rangeOfString:@"set"].location == 0) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
//    } else {
//        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
//    }
//}
//- (NSMethodSignature *)methodSignatureForSelectorOriginal:(SEL)aSelector {
//    return nil;
//}
//
//- (void)BKSafe_forwardInvocation:(NSInvocation *)anInvocation {
//    
//    Class cls = [anInvocation.target class];
//    class_addMethod(cls, anInvocation.selector, (IMP)crashFunction, "v@:@@");
//    if ([anInvocation.target respondsToSelector:anInvocation.selector]) {
//        [anInvocation invokeWithTarget:anInvocation.target];
//    }
//}
//
//- (void)forwardInvocationOriginal:(NSInvocation *)anInvocation {
//    
//}


//void crashFunction(id self, SEL _cmd, ...) {
//    id value = nil;
//    NSString *selString = NSStringFromSelector(_cmd);
//    
//    int cnt = 0, length = (int)selString.length;
//    NSRange range = NSMakeRange(0, length);
//    while(range.location != NSNotFound)
//    {
//        range = [selString rangeOfString: @":" options:0 range:range];
//        if(range.location != NSNotFound)
//        {
//            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
//            cnt++;
//        }
//    }
//    
//    va_list arg_ptr;
//    va_start(arg_ptr, _cmd);
//    
//    for(int i = 0; i < cnt; i++)
//    {
//        value = va_arg(arg_ptr, id);
//        NSLog(@"value%d=%@", i+1, value);
//    }
//    va_end(arg_ptr);
//    NSLog(@"程序崩溃!");
//}
@end
