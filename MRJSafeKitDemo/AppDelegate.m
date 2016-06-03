//
//  AppDelegate.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "AppDelegate.h"
#import "NSArray+safety.h"
//#import "NSArray_MRJSafe.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *vc = [[ViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];   
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    
    NSSet *set = [NSSet setWithObjects:nil,@"1",@"2",@"3", nil];
    NSSet *set1 = [NSSet setWithObject:nil];
    
//    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",nil,@"2", nil,nil];
    // Override point for customization after application launch.
    NSArray *arr = [[NSArray alloc]initWithObjects:@"1", nil];
//    NSString *obj1 = @"1";//__NSCFContstantString
//    NSString *obj2 = [NSString alloc];//NSPlaceholderString
//    NSString *obj3= [[NSString alloc]init];//__NSCFContstantString
//    NSString *obj4 = [NSString stringWithFormat:@"2"];//NSTaggedPointString
//    NSString *obj5 = [NSString stringWithFormat:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"];//超过64的长度_NSCFString
//    NSString *obj6 = [NSString stringWithUTF8String:"c"];//NSTaggedPointString
//    NSString *obj7 = [NSString stringWithUTF8String:"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"];//__NSCFString
//    
    
//    NSString *str = @"123";
//    NSString *str2 = [str substringFromIndex:9];
//    
//    NSMutableString *mStr = [[NSMutableString alloc]initWithString:str];
////    id value = [mStr substringFromIndex:10];
//    NSString *str3 = [str2 stringByAppendingString:nil];
//    NSString *str4 = [str2 stringByAppendingFormat:@"1",nil,nil];
////    id value = [arr objectAtIndex:1];
    
//    NSDictionary *dict = @{@"1":@"1",@"1",ni};
//    NSDictionary *d = @{@"1":@"2",@"nil":@"1"};
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:nil,@"hhh",@"ggg",@"jjj",nil,@"kkk",nil];
//    NSArray *rrr = [[NSArray alloc]initWithArray:nil];
//    NSArray *ar = [[NSArray alloc]initWithObjects:nil,nil, nil];
//    id ob = ar[1];
//    
//    NSArray *subarr = [ar subarrayWithRange:NSMakeRange(10, 10)];
//    
//    NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:nil,nil,@"2",@"3",nil,nil, nil];
//////    [arr addObserver:self forKeyPath:@"_count" options:NSKeyValueObservingOptionNew context:NULL];
//    id obj1 = [arr objectAtIndex:10];
//    [arr addObject:@"a"];
//    id obj2 = [arr subarrayWithRange:NSMakeRange(10, 10)];
//    [arr replaceObjectAtIndex:8 withObject:@"kkk"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
