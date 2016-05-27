//
//  NSMutableArray+BKSafe.m
//  BKSafeKit
//
//  Created by BestKai on 16/5/27.
//  Copyright © 2016年 BestKai. All rights reserved.
//

#import "NSMutableArray+BKSafe.h"
#import "NSObject+BKSwizzling.h"

@implementation NSMutableArray (BKSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 对象方法 __NSArrayM 和__NSArrayI 都有
        NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
        
        [mutableArr swizzleInstanceSelector:@selector(objectAtIndex:) withNewSelector:@selector(BKSafe_objectAtIndex:)];
        [mutableArr swizzleInstanceSelector:@selector(addObject:) withNewSelector:@selector(BKSafe_addObject:)];
        [mutableArr swizzleInstanceSelector:@selector(insertObject:atIndex:) withNewSelector:@selector(BKSafe_insertObject:atIndex:)];
    });
}


- (id)BKSafe_objectAtIndex:(NSUInteger)index
{
    if (index< self.count) {
        return [self BKSafe_objectAtIndex:index];
    }
    return nil;
}

- (void)BKSafe_addObject:(id)object
{
    if (object) {
        [self BKSafe_addObject:object];
    }else
    {
        BKAssert(NO, @"NSMutableArray invalid args BKSafe_addObject:[%@]", object);
    }
}


- (void)BKSafe_insertObject:(id)object atIndex:(NSUInteger)index
{
    if (object && index<= self.count) {
        [self BKSafe_insertObject:object atIndex:index];
    }else
    {
        if (!object) {
            BKAssert(NO, @"NSMutableArray invalid args BKSafe_insertObject:[%@] atIndex:[%@]", object, @(index));
        }
        if (index > self.count) {
            BKAssert(NO, @"NSMutableArray BKSafe_insertObject[%@] atIndex:[%@] out of bound:[%@]", object, @(index), @(self.count));
        }
    }
}

- (void)BKSafe_removeObjectAtInex:(NSUInteger)index
{
    if (index < self.count) {
        [self BKSafe_removeObjectAtInex:index];
    }else
    {
        BKAssert(NO, @"NSMutableArray BKSafe_removeObjectAtInex:[%@] out of bound:[%@]", @(index), @(self.count));
    }
}

- (void)BKSafe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    if (index< self.count && object) {
        [self BKSafe_replaceObjectAtIndex:index withObject:object];
    }else
    {
        if (!object) {
            BKAssert(NO, @"NSMutableArray invalid args BKSafe_replaceObjectAtIndex:[%@] withObject:[%@]", @(index), object);
        }
        if (index >= self.count) {
            BKAssert(NO, @"NSMutableArray BKSafe_replaceObjectAtIndex:[%@] withObject:[%@] out of bound:[%@]", @(index), object, @(self.count));
        }
    }
}


@end
