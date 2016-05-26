//
//  UIViewController+track.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "UIViewController+track.h"
#import "NSObject+Swizzle.h"
@implementation UIViewController (track)




+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        [class cls:class swizzleInstanceMethods:@selector(viewWillAppear:)];
    });
}

#pragma mark - Method Swizzling

- (void)mrjSafe_viewWillAppear:(BOOL)animated {
    [self mrjSafe_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}
@end
