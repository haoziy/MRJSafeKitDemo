//
//  NSArray+safety.m
//  MRJSafeKit
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSArray+safety.h"
#include <objc/objc-runtime.h>


@implementation NSArray (safety)

-(id)swizzled_objectAtIndex:(NSUInteger)index;
{
    return nil;
}

-(id)my_objectAtIndex:(NSUInteger)index;
{
    NSLog(@"新方法");
    return nil;
}
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    });
}

@end
