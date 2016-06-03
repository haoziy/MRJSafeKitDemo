//
//  NSMutableDictionary+Safe.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/6/3.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableDictionary (Safe)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary* obj = [[NSMutableDictionary alloc] init];
        [obj swizzleInstanceMethods:@selector(setObject:forKey:),nil];
        [obj release];
    });
}

-(void)mrjSafe_setObject:(id)anObject forKey:(id<NSCopying>) aKey
{
    if (anObject&&aKey) {
        [self mrjSafe_setObject:anObject forKey:aKey];
    }
    
}
@end
