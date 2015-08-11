//
//  HYWTabBarController.m
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWTabBarController.h"
#import "HYWNavController.h"
#import "HYWEssenceVC.h"
#import "HYWFriendTrendVc.h"
#import "HYWMeVc.h"
#import "HYWNewVC.h"
#import "HYWTabBar.h"
#import "HYWPublishController.h"

@interface HYWTabBarController ()@end

@implementation HYWTabBarController

/**
 *  初始化操作
 */
+ (void)initialize {
    NSMutableDictionary *norAttr = [NSMutableDictionary dictionary];
    norAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    NSMutableDictionary *highAttr = [NSMutableDictionary dictionary];
    highAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:norAttr forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:highAttr forState:UIControlStateSelected];
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
} // 设置文字不渲染

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
    [self setValue:[[HYWTabBar alloc] init] forKeyPath:@"tabBar"];
    [self setupPublishButton];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
} // 添加子控制器




/**
 *  添加子控制器
 */
- (void)setupChildControllers {
    HYWEssenceVC *vc1 = [[HYWEssenceVC alloc] init];
    HYWNewVC *vc2 = [[HYWNewVC alloc] init];
    HYWFriendTrendVc *vc3 = [[HYWFriendTrendVc alloc] init];
    HYWMeVc *vc4 = [[HYWMeVc alloc] init];
    [self setUpChildVc:vc1 title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setUpChildVc:vc2 title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setUpChildVc:vc3 title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setUpChildVc:vc4 title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}

/**
 *  添加发布按钮
 */
- (void)setupPublishButton {
    UIButton *publishButton = [[UIButton alloc] init];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    publishButton.size = publishButton.currentBackgroundImage.size;
    publishButton.center = CGPointMake(self.tabBar.viewWidth * 0.5, self.tabBar.viewHeight * 0.5);
    [publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:publishButton];
}


/**
 *  发布按钮点击方法
 */
- (void)publishButtonClick {
    HYWPublishController *publishVc = [[HYWPublishController alloc] init];
    [self presentViewController:publishVc animated:YES completion:nil];
}

/**
 *  子控制器添加方法
 */
- (void)setUpChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    HYWNavController *nav = [[HYWNavController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
} // 设置子控制器方法

@end
