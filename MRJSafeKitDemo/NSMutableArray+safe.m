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

//typedef void 
//
//typedef (*void)mrjSafe_addObject (void)mrjSafe_addObject

//typedef void (mrjSafe_addObject)(id, SEL, NSInteger);

-(void)swizzled_addObject:(id)anObject
{
    NSLog(@"新方法");
}
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        
        NSMutableArray* obj = [[NSMutableArray alloc] init];
//        对象方法 __NSArrayM 和 __NSArrayI 都有实现，都要swizz
        [obj swizzleInstanceMethods:
         @selector(insertObject:atIndex:),@selector(replaceObjectAtIndex:withObject:),@selector(removeObjectsInRange:),@selector(addObject:),@selector(objectAtIndex:),@selector(subarrayWithRange:),nil];
        [obj release];
    });
}
-(id)mrjSafe_objectAtIndex:(NSInteger)index
{
    NSInteger count = self.count-1;
    if(index>count)
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

    if(range.location+range.length>self.count)
    {
        
        return ;
    }
    [self mrjSafe_removeObjectsInRange:range];
    
    
}

-(id)mrjSafe_subarrayWithRange:(NSRange)range
{
    if(range.location+range.length>self.count)
    {
        
        return nil;
    }
    
    return [self mrjSafe_subarrayWithRange:range];
    
}




@end
