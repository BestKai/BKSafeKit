//
//  NSString+BKSafe.m
//  BKSafeKit
//
//  Created by BestKai on 16/5/28.
//  Copyright © 2016年 BestKai. All rights reserved.
//

#import "NSString+BKSafe.h"
#import "NSObject+BKSwizzling.h"

@implementation NSString (BKSafe)


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 普通方法
       NSString *obj = [[NSString alloc] init];
        [obj swizzleInstanceSelector:@selector(stringByAppendingString:) withNewSelector:@selector(BKSafe_stringByAppendingString:)];
    });
}

- (NSString *)BKSafe_stringByAppendingString:(NSString *)string
{
    if (string) {
        return [self BKSafe_stringByAppendingString:string];
    }
    
    NSAssert(NO, @"%@ [%@ %@] invalid args [null]",LogPrefix,[self class],NSStringFromSelector(_cmd));
    
    return self;
}

@end
