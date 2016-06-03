//
//  NSArray+safety.m
//  MRJSafeKit
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSArray+safety.h"
#import "NSObject+Swizzle.h"


@implementation NSArray (safety)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSArray swizzleClassMethods:@selector(arrayWithObject:),nil];
        
        /* 数组有内容obj类型__NSArrayI */
        NSArray* obj1 = [[NSArray alloc] initWithObjects:@0, nil];
        
        [obj1 swizzleInstanceMethods:@selector(objectAtIndex:),@selector(subarrayWithRange:),nil];
        
        
        /* 数组没内容的类型 数组有内容obj类型__NSArray0*/
        NSArray *obj0 = [[NSArray alloc]init];
        [obj0 swizzleInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(arry0_objectAtIndex:)];
        [obj0 swizzleInstanceMethod:@selector(subarrayWithRange:) withMethod:@selector(arry0_subarrayWithRange:)];
        [obj0 release];
        [obj1 release];
    });
}

+(instancetype)mrjSafe_arrayWithObject:(id)anObject
{
    if (!anObject) {
        return nil;
    }
    return [self mrjSafe_arrayWithObject:anObject];
}
-(id)mrjSafe_objectAtIndex:(NSUInteger)index
{
    NSInteger count = self.count-1;
    if (index>count) {
        return nil;
    }
    return [self mrjSafe_objectAtIndex:index];
}
-(id)arry0_objectAtIndex:(NSInteger)index
{
    NSInteger count = self.count-1;
    if (index>count) {
        return nil;
    }
    return [self arry0_objectAtIndex:index];
}
-(id)mrjSafe_subarrayWithRange:(NSRange)range
{
    if(range.location+range.length>self.count)
    {
        
        return nil;
    }
    
    return [self mrjSafe_subarrayWithRange:range];
    
}
-(id)arry0_subarrayWithRange:(NSRange)range
{
    if(range.location+range.length>self.count)
    {
        
        return nil;
    }
    
    return [self arry0_subarrayWithRange:range];
}

@end
