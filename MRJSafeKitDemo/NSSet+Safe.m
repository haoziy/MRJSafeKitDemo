//
//  NSSet+Safe.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/6/3.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSSet+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSSet (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 类方法 */
        [NSSet swizzleClassMethods:@selector(setWithObject:),@selector(setWithObjects:),nil];
        
    });
}

+(instancetype)setWithObjects:(id)firstObj, ...
{
    NSMutableSet *set = [NSMutableSet set];
    va_list args;
    va_start(args, firstObj);
    if (firstObj)
    {
        [set addObject:firstObj];
        while (YES) {
            id otherObj = va_arg(args, id);
            if (!otherObj) {
                break;
            }
            [set addObject:otherObj];
        }
        
    }
    va_end(args);
    return set;
}
+(instancetype)mrjSafe_setWithObject:(id)object
{
    if (object) {
        return [self mrjSafe_setWithObject:object];
    }
    return nil;
}

@end
