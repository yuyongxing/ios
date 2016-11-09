//
//  CCBaseNVC.m
//  ShouCheShenQi
//
//  Created by mac on 2016/11/4.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import "CCBaseNVC.h"

@interface CCBaseNVC ()

@end

@implementation CCBaseNVC

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 隐藏导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        
        //        // 自定义返回按钮
        //        UIButton *btn = [[UIButton alloc] init];
        //        [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        //        [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        //        [btn sizeToFit];
        //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        //
        //        // 自定义只有图片的返回按钮
        //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAnimated:)];
        //
        //        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        //        __weak typeof(viewController)Weakself = viewController;
        //        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    [super pushViewController:viewController animated:animated];
}

@end
