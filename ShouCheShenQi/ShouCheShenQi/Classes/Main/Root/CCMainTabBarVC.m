//
//  CCMainTabBarVC.m
//  ShouCheShenQi
//
//  Created by mac on 2016/11/4.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import "CCMainTabBarVC.h"
#import "CCBaseNVC.h"
#import "CCHomeVC.h"
#import "CCMessageVC.h"
#import "CCMineVC.h"

@interface CCMainTabBarVC ()

@end

@implementation CCMainTabBarVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupTabBarController];
        [self customizeTabBarAppearance];
    }
    return self;
}

- (void)setupTabBarController {
    //    self.imageInsets = UIEdgeInsetsMake(-25, 0, 25, 0);//一定要写在前面
    
    /// 设置TabBar属性数组
    self.tabBarItemsAttributes = self.tabBarItemsAttributesForController;
    
    /// 设置控制器数组
    self.viewControllers = self.viewControlleres;
    
    //设置代理
//    self.delegate = self;
    
    //    // 自定义 TabBar 高度
    //    self.tabBarHeight = 30.f;
}

- (NSArray *)viewControlleres {
    CCHomeVC *homeVC = [[CCHomeVC alloc] init];
    UIViewController *homeNavigationController = [[CCBaseNVC alloc]
                                                   initWithRootViewController:homeVC];
    
    CCMessageVC *messageVC = [[CCMessageVC alloc] init];
    UIViewController *messageNavigationController = [[CCBaseNVC alloc]
                                                    initWithRootViewController:messageVC];
    
    CCMineVC *mineVC = [[CCMineVC alloc] init];
    UIViewController *mineNavigationController = [[CCBaseNVC alloc]
                                                   initWithRootViewController:mineVC];
    
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 messageNavigationController,
                                 mineNavigationController,
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"11",
                                                 CYLTabBarItemSelectedImage : @"sh",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"消息",
                                                  CYLTabBarItemImage : @"11",
                                                  CYLTabBarItemSelectedImage : @"sh",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"我的",
                                                 CYLTabBarItemImage : @"11",
                                                 CYLTabBarItemSelectedImage : @"sh",
                                                 };

    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance{
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    //    [UITabBar appearance].barTintColor = [UIColor greenColor];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - UITabBarControllerDelegate

//- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UINavigationController*)viewController {
//    /// 特殊处理 - 是否需要登录
//    BOOL isBaiDuService = [viewController.topViewController isKindOfClass:[SecondViewController class]];
//    if (isBaiDuService) {
//        NSLog(@"你点击了TabBar第二个");
//    }
//    return YES;
//}

@end
