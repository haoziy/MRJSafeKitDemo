//
//  NSObject+Safe.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSObject+Safe.h"

@implementation NSObject (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         NSObject* obj = [[NSObject alloc] init];
        [self cls:[obj class] swizzleInstanceMethods:@selector(addObserver:forKeyPath:options:context:),nil];
    });
}
- (void) mrjSafe_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if (!observer || !keyPath.length) {
        return;
    }
    [self mrjSafe_addObserver:observer forKeyPath:keyPath options:options context:context];

}
- (void)mrjSafe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    if (!observer || !keyPath.length) {
        return;
    }else
    {
        [self mrjSafe_removeObserver:observer forKeyPath:keyPath];
    }
}

@end
