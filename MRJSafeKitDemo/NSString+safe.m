//
//  NSString+safe.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSString+safe.h"
#import <objc/runtime.h>
#import "NSObject+Swizzle.h"
@implementation NSString (safe)



-(id)mrjSafe_characterAtIndex:(NSUInteger)index;
{
    
    if(index>self.length-1)
    {
        return NULL;
    }
   return  [self mrjSafe_characterAtIndex:index];
}
-(id)mrjSafe_substringFromIndex:(NSInteger)index
{
    if (index>self.length-1) {
        return nil;
    }
    return [self mrjSafe_substringFromIndex:index];
}
-(id)mrjSafe_substringToIndex:(NSInteger)index
{
    if (index>self.length-1) {
        return nil;
    }
    return [self mrjSafe_substringToIndex:index];
}
-(id)mrjSafe_substringWithRange:(NSRange)range
{
    if (range.location+range.length>self.length) {
        return nil;
    }
    return [self mrjSafe_substringWithRange:range];
}
+(id)mrjSafe_initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding;
{
    if (nullTerminatedCString==NULL) {
        return nil;
    }
    return [self mrjSafe_initWithCString:nullTerminatedCString encoding:encoding];
}
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *obj1 = @"1";//__NSCFContstantString
        NSString *obj2 = [NSString alloc];//NSPlaceholderString
        NSString *obj3= [[NSString alloc]init];//__NSCFContstantString
        NSString *obj4 = [NSString stringWithFormat:@"2"];//NSTaggedPointString
        NSString *obj5 = [NSString stringWithFormat:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"];//超过64的长度_NSCFString
        NSString *obj6 = [NSString stringWithUTF8String:"c"];//NSTaggedPointString
        NSString *obj7 = [NSString stringWithUTF8String:"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"];//__NSCFString
        //NSString 类簇系列方法归宿;
        //1:NSTaggedPointerString;//参考头文件NSTaggedPointerString.h
        /**
         *  NSTaggedPointString中涉及到可以异常的方法
         *   - (unsigned short)characterAtIndex:(unsigned long long)arg1;
         *  - (id)substringWithRange:(struct _NSRange { unsigned long long x1; unsigned long long x2; })arg1;
         *
         */
//        Class cls_NSTaggedPointerString = NSClassFromString(@"NSTaggedPointerString");
//
//        [self cls:[cls_NSTaggedPointerString class] swizzleInstanceMethods:@selector(characterAtIndex:),nil];
        
        //2:NSPlaceholderString;
        /**
         *  <#Description#>
         */
       
//        Class cls_NSPlaceholderStringg = NSClassFromString(@"NSPlaceholderString");
//
//        [self cls:[cls_NSPlaceholderStringg class] swizzleInstanceMethods:@selector(characterAtIndex:),nil];
        
        
        //3:NSCFContstantString;
        Class cls_NSCFContstantString = NSClassFromString(@"__NSCFContstantString");
        [self cls:[cls_NSCFContstantString class] swizzleInstanceMethods:@selector(substringFromIndex:),@selector(substringToIndex:),@selector(substringWithRange:),nil];
        
        
        //4:__NSCFString;
        /**
         *  - (id)substringWithRange:(struct _NSRange { unsigned int x1; unsigned int x2; })arg1;
         * - (unsigned int)replaceOccurrencesOfString:(id)arg1 withString:(id)arg2 options:(unsigned int)arg3 range:(struct _NSRange { unsigned int x1; unsigned int x2; })arg4;
         * - (void)replaceCharactersInRange:(struct _NSRange { unsigned int x1; unsigned int x2; })arg1 withString:(id)arg2;
         * - (void)insertString:(id)arg1 atIndex:(unsigned int)arg2;
         * - (void)getCharacters:(unsigned short*)arg1 range:(struct _NSRange { unsigned int x1; unsigned int x2; })arg2;
         * 
         */
        Class cls__NSCFString = NSClassFromString(@"NSString");
        
        [self cls:[obj7 class] swizzleInstanceMethods:@selector(characterAtIndex:),nil];
//        [self cls:[self class] swizzleInstanceMethods:@selector(characterAtIndex:),nil];
        
        
        
        
    });
}
@end
