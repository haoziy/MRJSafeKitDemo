//
//  NSMutableArray+safe.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSMutableArray+safe.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableArray (safe)



-(void)swizzled_addObject:(id)anObject
{
    NSLog(@"新方法");
}
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        
        NSMutableArray* obj = [[NSMutableArray alloc] init];
        [obj cls:[obj class] swizzleInstanceMethods:@selector(objectAtIndex:),@selector(addObject:),@selector(insertObject:atIndex:),@selector(replaceObjectAtIndex:withObject:),@selector(removeObjectsInRange:),@selector(subarrayWithRange:),nil];
//        对象方法 __NSArrayM 和 __NSArrayI 都有实现，都要swizz
    });
}
-(id)mrjSafe_objectAtIndex:(NSInteger)index
{
    if(index>self.count-1)
    {
        return nil;
    }
    return [self mrjSafe_objectAtIndex:index];
    
}
-(void)mrjSafe_addObject:(id)obj
{
    if(!obj)
    {
        return ;
    }
    [self mrjSafe_addObject:obj];
    
}

-(void)mrjSafe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject) {
        return;
    }
    if (index>self.count) {
        return;
    }
    [self mrjSafe_insertObject:anObject atIndex:index];
}
-(void)mrjSafe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (!anObject) {
        return;
    }
    if (index>self.count) {
        return;
    }
    [self mrjSafe_replaceObjectAtIndex:index withObject:anObject];
}
-(void)mrjSafe_removeObjectsInRange:(NSRange)range
{
//    if(range.location+range.length>self.count-1)
//    {
//        return ;
//    }
    [self mrjSafe_removeObjectsInRange:range];
    
}

-(id)mrjSafe_subarrayWithRange:(NSRange)range
{
    if(range.location+range.length>self.count-1)
    {
        return nil;
    }
    return [self mrjSafe_subarrayWithRange:range];
}




@end
