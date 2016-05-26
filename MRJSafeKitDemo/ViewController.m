//
//  ViewController.m
//  MRJSafeKitDemo
//
//  Created by ZEROLEE on 16/5/16.
//  Copyright © 2016年 laomi. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+track.h"
#import "NSArray+safety.h"
#import "NSString+safe.h"
#import "NSMutableArray+safe.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"aaaa";
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
//    self.automaticallyAdjustsScrollViewInsets
    
//    NSArray *arr = @[@"1",@"2"];
//    id value = [arr objectAtIndex:1];
//    NSLog(@"%@",value);
//    
//    
//    NSString *str = @"汉字agdgfdg";
//    char c = [str characterAtIndex:1];
//    
//    NSMutableArray *mArr = [[NSMutableArray alloc]init];
//    [mArr addObject:@"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)test
{
    UIViewController *v = [[UIViewController alloc]init];
    [self.navigationController pushViewController:v animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
