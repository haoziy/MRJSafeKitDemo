//
//  NSOrderedSet+Safe.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/6/3.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSOrderedSet+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSOrderedSet (Safe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [NSOrderedSet swizzleClassMethods:@selector(orderedSetWithObject:),@selector(orderedSetWithObjects:), nil];
        
        NSOrderedSet* obj0 = [NSOrderedSet alloc];
        [obj0 swizzleInstanceMethods:@selector(initWithObject:),nil];
        [obj0 release];
        
        
        NSOrderedSet *obj1 = [NSOrderedSet orderedSetWithObjects:@0, nil];
        [obj1 swizzleInstanceMethods:@selector(objectAtIndex:),nil];
    });
}
+(instancetype)mrjSafe_orderedSetWithObject:(id)object
{
    if (object) {
        return [self mrjSafe_orderedSetWithObject:object];
    }
    return nil;
}
+ (instancetype)mrjSafe_orderedSetWithObjects:(id)firstObj, ...
{
    if (firstObj==nil) {
        return nil;
    }
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSet];
    va_list list;
    //遍历开始
    va_start(list, firstObj);
    while (YES) {
        
        id obj = va_arg(list,id);
        if (obj) {
            [set addObject:obj];
        }else
        {
            break;
        }
        
    }
    va_end(list);
    
    return set;
}
-(id)mrjSafe_objectAtIndex:(NSInteger)index
{
    NSInteger count = self.count-1;
    if (index>count||index==0) {
        return nil;
    }
    return [self mrjSafe_objectAtIndex:index];
}
@end
