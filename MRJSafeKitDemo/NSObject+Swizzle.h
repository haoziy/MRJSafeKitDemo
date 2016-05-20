//
//  NSObject+Swizzle.h
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define MRJFunctionPrefix @"mrjSafe"
@interface NSObject (Swizzle)


-(void)cls:(Class)cls swizzleClassMethods:(SEL)oldSelectors,...;

-(void)cls:(Class)cls swizzleInstanceMethods:(SEL)oldSelectors, ...;

+ (void)exchangeClassOldSelector:(SEL)oldSelector withNewSelector:(SEL)newSelector;
- (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;
@end
