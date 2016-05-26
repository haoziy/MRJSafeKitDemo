//
//  NSObject+Swizzle.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
//
//typedef void (*HookFunc_Signature)(id, SEL); // << != IMP's signature
//static HookFunc_Signature gOriginalFunc = nil;

@implementation NSObject (Swizzle)




#pragma mark --swizzleClassMethods
+(void)swizzleClassMethods:(SEL)oldSelectors,...
{
    NSString *oldSelString = NSStringFromSelector(oldSelectors);
    NSString *newSelString = [NSString stringWithFormat:@"%@_%@",MRJFunctionPrefix,oldSelString];
    SEL newSel = NSSelectorFromString(newSelString);
    [self exchangeClassOldSelector:oldSelectors withNewSelector:newSel];

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
        [self exchangeClassOldSelector:oldSel withNewSelector:newSel];
    }
    //结束可变参数的获取
    va_end(list);
}
#pragma mark --swizzleInstanceMethods
-(void)swizzleInstanceMethods:(SEL)oldSelectors, ...
{
    NSString *oldSelString = NSStringFromSelector(oldSelectors);
    NSString *newSelString = [NSString stringWithFormat:@"%@_%@",MRJFunctionPrefix,oldSelString];
    SEL newSel = NSSelectorFromString(newSelString);
    [self swizzleInstanceMethod:oldSelectors withMethod:newSel];
    //变参部分
    va_list list;
    va_start(list, oldSelectors);
    while (YES)
    {
        //返回可变参数，va_arg第二个参数为可变参数类型，如果有多个可变参数，依次调用可获取各个参数
        SEL oldSel = va_arg(list, SEL);
        if (!oldSel) {
            break;
        }
        
        NSString *oldSelString = NSStringFromSelector(oldSel);
        if(oldSelString.length==0)
        {
            break;
        }
        NSString *newSelString = [NSString stringWithFormat:@"%@_%@",MRJFunctionPrefix,oldSelString];
        SEL newSel = NSSelectorFromString(newSelString);
        [self swizzleInstanceMethod:oldSel withMethod:newSel];
    }
    va_end(list);
}

#pragma mark --exchange InstanceMethods
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
#pragma mark --exchange ClassMethods
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
