//
//  NSObject+BKSwizzling.h
//  BKSafeKit
//
//  Created by BestKai on 16/5/27.
//  Copyright © 2016年 BestKai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BKAssert(condition, ...) \
if (!(condition)){ BKLog(__FILE__, __FUNCTION__, __LINE__, __VA_ARGS__);} \
NSAssert(condition, @"%@", __VA_ARGS__);

void BKLog(const char* file, const char* func, int line, NSString* fmt, ...);

@interface NSObject (BKSwizzling)

//替换对象方法
- (void)swizzleInstanceSelector:(SEL)origSelector withNewSelector:(SEL)newSelector;
//替换类方法
+ (void)swizzleClassSelector:(SEL)origSelector withNewSelector:(SEL)newSelector;


@end
