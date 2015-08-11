//
//  HYWNavController.m
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWNavController.h"

@implementation HYWNavController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
} // 设置tabBar背景图片

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
} // 设置返回item

- (void)pop {
    [self popViewControllerAnimated:YES];
} // 返回方法

@end
