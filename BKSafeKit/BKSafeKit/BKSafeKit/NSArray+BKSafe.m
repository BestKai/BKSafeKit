//
//  NSArray+BKSafe.m
//  BKSafeKit
//
//  Created by BestKai on 16/5/27.
//  Copyright © 2016年 BestKai. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSArray+BKSafe.h"
#import "NSObject+BKSwizzling.h"
@implementation NSArray (BKSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 数组有内容obj类型才是__NSArrayI
        NSArray* obj = [[NSArray alloc] initWithObjects:@0, nil];
        
        [obj swizzleInstanceSelector:@selector(objectAtIndex:) withNewSelector:@selector(BKSafe_objectAtIndexI:)];
        //ios 9.0以上没内容数组是__NSArray0
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >=9.0) {
            obj = [[NSArray alloc] init];
            [self swizzleInstanceSelector:@selector(objectAtIndex:) withNewSelector:@selector(BKSafe_objectAtIndex0:)];
        }
    });
}

- (id)BKSafe_objectAtIndexI:(NSUInteger)index
{
    if (index>=self.count) {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu]",
              NSStringFromClass([self class]), NSStringFromSelector(_cmd), (unsigned long)index,
              MAX((unsigned long)self.count - 1, 0));
        return nil;
    }
    return [self BKSafe_objectAtIndexI:index];
}


- (id)BKSafe_objectAtIndex0:(NSUInteger)index
{
    return nil;
}

@end
