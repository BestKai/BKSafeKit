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

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
        [mutableDic swizzleInstanceSelector:@selector(setObject:forKey:) withNewSelector:@selector(BKSafe_setObject:forKey:)];
        [mutableDic swizzleInstanceSelector:@selector(removeObjectForKey:) withNewSelector:@selector(BKSafe_removeObjectForKey:)];
    });
}


- (void)BKSafe_setObject:(id)object forKey:(id<NSCopying>)key
{
    if (!object) {
        return;
    }
    if (!key) {
        return;
    }
    
    [self BKSafe_setObject:object forKey:key];
}

- (void)BKSafe_removeObjectForKey:(id<NSCopying>)key
{
    if (!key) {
        return;
    }
    [self BKSafe_removeObjectForKey:key];
}

@end
