//
//  NSObject+Swizzle.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

-(void)cls:(Class)cls swizzleInstanceMethods:(SEL)oldSelectors, ...;
{
    NSString *oldSelString = NSStringFromSelector(oldSelectors);
    NSString *newSelString = [NSString stringWithFormat:@"%@_%@",MRJFunctionPrefix,oldSelString];
    SEL newSel = NSSelectorFromString(newSelString);
//    [self obj:cls exchangeInstanceOldMethod:oldSelectors withNewMethod:newSel];
    [self swizzleInstanceMethod:oldSelectors withMethod:newSel];
    //指向变参的指针
    va_list list;
    //使用第一个参数来初使化list指针
    va_start(list, oldSelectors);
    while (YES)
    {
        //返回可变参数，va_arg第二个参数为可变参数类型，如果有多个可变参数，依次调用可获取各个参数
        SEL oldSel = va_arg(list, SEL);
        if (!oldSel) {
            break;
        }
        
        NSString *oldSelString = NSStringFromSelector(oldSel);
        NSString *newSelString = [NSString stringWithFormat:@"%@_%@",MRJFunctionPrefix,oldSelString];
        SEL newSel = NSSelectorFromString(newSelString);
        [self swizzleInstanceMethod:oldSelectors withMethod:newSel];
    }
    //结束可变参数的获取
    va_end(list);
}

-(void)cls:(Class)cls swizzleClassMethods:(SEL)oldSelectors,...;
{

    NSString *oldSelString = NSStringFromSelector(oldSelectors);
    NSString *newSelString = [NSString stringWithFormat:@"%@_%@",MRJFunctionPrefix,oldSelString];
    SEL newSel = NSSelectorFromString(newSelString);
    [self obj:cls exchangeClassOldMethod:oldSelectors withNewMethod:newSel];
    //指向变参的指针
    va_list list;
    //使用第一个参数来初使化list指针
    va_start(list, oldSelectors);
    while (YES)
    {
        //返回可变参数，va_arg第二个参数为可变参数类型，如果有多个可变参数，依次调用可获取各个参数
        SEL oldSel = va_arg(list, SEL);
        if (!oldSel) {
            break;
        }
        
        NSString *oldSelString = NSStringFromSelector(oldSel);
        NSString *newSelString = [NSString stringWithFormat:@"%@_%@",MRJFunctionPrefix,oldSelString];
        SEL newSel = NSSelectorFromString(newSelString);
        [self obj:cls exchangeClassOldMethod:oldSel withNewMethod:newSel];
    }
    //结束可变参数的获取
    va_end(list);
}
-(void)obj:(Class)cls exchangeInstanceOldMethod:(SEL)oldSelector withNewMethod:(SEL)newSelector;
{
    Method oldMethod = class_getInstanceMethod(cls, oldSelector);
    Method newMethod = class_getInstanceMethod(cls, newSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        oldSelector,
                        method_getImplementation(newMethod),
                        method_getTypeEncoding(newMethod)) )
    {
        class_replaceMethod(metacls,
                            newSelector,
                            method_getImplementation(oldMethod),
                            method_getTypeEncoding(newMethod));
        
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}
-(void)obj:(Class)cls exchangeClassOldMethod:(SEL)oldSelector withNewMethod:(SEL)newSelector;
{
    Method oldMethod = class_getClassMethod(cls, oldSelector);
    Method newMethod = class_getClassMethod(cls, newSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        oldSelector,
                        method_getImplementation(newMethod),
                        method_getTypeEncoding(newMethod)) )
    {
        class_replaceMethod(metacls,
                            newSelector,
                            method_getImplementation(oldMethod),
                            method_getTypeEncoding(newMethod));
        
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}
- (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;
{
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    if (class_addMethod(cls,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /*swizzing super class instance method, added if not exist */
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
+ (void)exchangeClassOldSelector:(SEL)oldSelector withNewSelector:(SEL)newSelector;
{
    Class cls = [self class];
    
    Method originalMethod = class_getClassMethod(cls, oldSelector);
    Method swizzledMethod = class_getClassMethod(cls, newSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        oldSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* swizzing super class method, added if not exist */
        class_replaceMethod(metacls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
