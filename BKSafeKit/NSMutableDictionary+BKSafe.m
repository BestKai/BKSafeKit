//
//  NSMutableDictionary+BKSafe.m
//  BKSafeKit
//
//  Created by BestKai on 16/5/27.
//  Copyright © 2016年 BestKai. All rights reserved.
//

#import "NSMutableDictionary+BKSafe.h"
#import "NSObject+BKSwizzling.h"

@implementation NSMutableDictionary (BKSafe)

#ifndef DEBUG
+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
        [mutableDic swizzleInstanceSelector:@selector(setObject:forKey:) withNewSelector:@selector(BKSafe_setObject:forKey:)];
        [mutableDic swizzleInstanceSelector:@selector(removeObjectForKey:) withNewSelector:@selector(BKSafe_removeObjectForKey:)];
    });
}
#endif

- (void)BKSafe_setObject:(id)object forKey:(id<NSCopying>)key
{
    if (!object) {
        
        NSAssert(NO, @"%@ [%@ %@] invalid object[%@] for key [%@]",LogPrefix,[self class],NSStringFromSelector(_cmd),object,key);

        return;
    }
    if (!key) {
        
        NSAssert(NO, @"%@ [%@ %@] invalid object[%@] for key [%@]",LogPrefix,[self class],NSStringFromSelector(_cmd),object,key);

        return;
    }
    
    [self BKSafe_setObject:object forKey:key];
}

- (void)BKSafe_removeObjectForKey:(id<NSCopying>)key
{
    if (!key) {
        NSAssert(NO, @"%@ [%@ %@] invalid  key [%@]",LogPrefix,[self class],NSStringFromSelector(_cmd),key);
        return;
    }
    [self BKSafe_removeObjectForKey:key];
}

@end
