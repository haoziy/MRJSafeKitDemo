//
//  NSMutableArray+safe.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSMutableArray+safe.h"
#import <objc/runtime.h>

@implementation NSMutableArray (safe)



-(void)swizzled_addObject:(id)anObject
{
    NSLog(@"新方法");
}
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

    });
}
@end
