//
//  UINavigationController+safePush.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/24.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "UINavigationController+safePush.h"
#import "NSObject+Swizzle.h"

@implementation UINavigationController (safePush)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UINavigationController* obj = [[UINavigationController alloc] init];
        [obj cls:[obj class] swizzleInstanceMethods:@selector(pushViewController:animated:),nil];
    });
}
-(void)mrjSafe_pushViewController:(UIViewController*)vc animated:(BOOL)animated
{
    if (!vc) {
        return;
    }
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    for (int x=0; x<viewControllers.count; x++) {
        UIViewController *item = viewControllers[x];
        if ([item isKindOfClass:[vc class]]) {
            [viewControllers removeObject:item];
        }
    }
    self.viewControllers = viewControllers;
    [self mrjSafe_pushViewController:vc animated:animated];
}
@end
