//
//  NSMutableString+safe.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/19.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "NSMutableString+safe.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableString (safe)

+(void)load
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableString* str  = [[NSMutableString alloc] init];
        [self cls:[str class] swizzleInstanceMethods:@selector(insertString:atIndex:),@selector(deleteCharactersInRange:),@selector(substringFromIndex:),@selector(substringToIndex:),@selector(substringWithRange:),nil];
    });
    
}
- (void)mrjSafe_insertString:(NSString *)aString atIndex:(NSUInteger)loc;
{
    if (loc>self.length-1) {
        return;
    }
    [self mrjSafe_insertString:aString atIndex:loc];
}
- (void)mrjSafe_deleteCharactersInRange:(NSRange)range;
{
    if (range.location+range.length>self.length) {
        return;
    }
    [self mrjSafe_deleteCharactersInRange:range];
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
@end
