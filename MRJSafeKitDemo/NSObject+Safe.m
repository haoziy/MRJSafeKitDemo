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
         NSObject* obj = [[[NSObject alloc] init]autorelease];
        [obj swizzleInstanceMethods:@selector(performSelector:),@selector(performSelector:withObject:afterDelay:),@selector(performSelector:withObject:withObject:),@selector(performSelectorOnMainThread:withObject:waitUntilDone:), nil];
        
        id obj2 = [[[self alloc]init]autorelease];
                    
        [obj2 swizzleInstanceMethods:@selector(addObserver:forKeyPath:options:context:),@selector(removeObserver:forKeyPath:),nil];
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

-(void)mrjSafe_performSelector:(SEL)aSelector
{
    [self mrjSafe_performSelector:aSelector];
}
-(void)mrjSafe_performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait
{
    [self mrjSafe_performSelectorOnMainThread:aSelector withObject:arg waitUntilDone:wait];
   
}

- (void)mrjSafe_performSelector:(SEL)aSelector withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay;
{
    [self mrjSafe_performSelector:aSelector withObject:anArgument afterDelay:delay];
    
}


        
@end
