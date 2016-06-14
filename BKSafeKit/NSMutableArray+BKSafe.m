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

#ifndef DEBUG
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
#endif

- (id)BKSafe_objectAtIndex:(NSUInteger)index
{
    if (index< self.count) {
        return [self BKSafe_objectAtIndex:index];
    }else
    {
        NSAssert(NO, @"%@ [%@ %@] index [%zd] beyond bounds %zd",LogPrefix,
                      NSStringFromClass([self class]), NSStringFromSelector(_cmd),index,MAX((signed long)self.count-1, 0));
    }
    return nil;
}

- (void)BKSafe_addObject:(id)object
{
    if (object) {
        [self BKSafe_addObject:object];
    }else
    {
        NSAssert(NO, @"%@ [%@ %@] invalid args [%@]",LogPrefix,[self class],NSStringFromSelector(_cmd),object);
    }
}


- (void)BKSafe_insertObject:(id)object atIndex:(NSUInteger)index
{
    if (object && index<= self.count) {
        [self BKSafe_insertObject:object atIndex:index];
    }else
    {
        if (!object) {
            
            NSAssert(NO, @"%@ [%@ %@] invalid args [%@]",LogPrefix,[self class],NSStringFromSelector(_cmd),object);
        }
        if (index > self.count) {
            
            NSAssert(NO, @"%@ [%@ %@] [%@] atIndex:[%@] out of bound:[%@] ",LogPrefix,[self class],NSStringFromSelector(_cmd),object,@(index),@(self.count));
        }
    }
}

- (void)BKSafe_removeObjectAtInex:(NSUInteger)index
{
    if (index < self.count) {
        [self BKSafe_removeObjectAtInex:index];
    }else
    {
        NSAssert(NO, @"%@ [%@ %@] [%@] out of bound:[%@] ",LogPrefix,[self class],NSStringFromSelector(_cmd),@(index),@(self.count));
    }
}

- (void)BKSafe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    if (index< self.count && object) {
        [self BKSafe_replaceObjectAtIndex:index withObject:object];
    }else
    {
        if (!object) {
            
            NSAssert(NO, @"%@ [%@ %@] invalid args [%@]",LogPrefix,[self class],NSStringFromSelector(_cmd),object);
        }
        if (index >= self.count) {
            
            NSAssert(NO, @"%@ [%@ %@] [%@] out of bound:[%@] ",LogPrefix,[self class],NSStringFromSelector(_cmd),@(index),@(self.count));
        }
    }
}


@end
