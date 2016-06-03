//
//  NSDictionary+Safe.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/6/3.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Swizzle.h"
@implementation NSDictionary (Safe)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSDictionary swizzleClassMethods:@selector(dictionaryWithObjectsAndKeys:),@selector(dictionaryWithObject:forKey:),nil];
        
        
        NSDictionary* obj = [NSDictionary dictionaryWithObjectsAndKeys:@0,@0,nil];
        [obj swizzleInstanceMethods:@selector(initWithObjectsAndKeys:),nil];        
    });
}



-(instancetype)mrjSafe_dictionaryWithObject:(id)object forKey:key
{
    if (object&&key) {
        return [self mrjSafe_dictionaryWithObject:object forKey:key];
    }
    return nil;
}
-(instancetype)mrjSafe_initWithObjectsAndKeys:(id)firstObject, ...
{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    NSInteger i = 1;
    id key = nil;
    id value = firstObject;
    va_list args;
    va_start(args, firstObject);
    if (firstObject)
    {
        
        while (YES) {
            id otherObj = va_arg(args, id);
            if (!otherObj) {
                break;
            }
            if (i%2==1)
            {
                key = otherObj;
            }else
            {
                value = otherObj;
            }
            i++;
            if (i%2==0) {
                [dict setObject:value forKey:key];
            }
        }
        
    }
    va_end(args);
    return dict;
}




+(instancetype)mrjSafe_dictionaryWithObject:(id)object forKey:key
{
    if (object&&key) {
        return [self mrjSafe_dictionaryWithObject:object forKey:key];
    }
    return nil;
}
+(instancetype)mrjSafe_dictionaryWithObjectsAndKeys:(id)firstObject, ...
{
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc]init] autorelease];
    
    NSInteger i = 1;
    id key = nil;
    id value = firstObject;
    va_list args;
    va_start(args, firstObject);
    if (firstObject)
    {
        
        while (YES) {
            id otherObj = va_arg(args, id);
            if (!otherObj) {
                break;
            }
            if (i%2==1)
            {
                key = otherObj;
            }else
            {
                value = otherObj;
            }
            i++;
            if (i%2==0) {
                [dict setObject:value forKey:key];
            }
        }

    }
    va_end(args);
    return dict;
}
@end
