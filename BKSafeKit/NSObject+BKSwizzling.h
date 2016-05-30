//
//  NSObject+BKSwizzling.h
//  BKSafeKit
//
//  Created by BestKai on 16/5/27.
//  Copyright © 2016年 BestKai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LogPrefix [NSString stringWithFormat:@"%s %d",__FILE__,__LINE__]

@interface NSObject (BKSwizzling)

//替换对象方法
- (void)swizzleInstanceSelector:(SEL)origSelector withNewSelector:(SEL)newSelector;
//替换类方法
+ (void)swizzleClassSelector:(SEL)origSelector withNewSelector:(SEL)newSelector;


@end
