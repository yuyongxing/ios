//
//  CCBaseVC.m
//  ShouCheShenQi
//
//  Created by mac on 2016/11/4.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import "CCBaseVC.h"

@interface CCBaseVC ()

@end

@implementation CCBaseVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _statusBarStyle  = UIStatusBarStyleDefault;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    UIImageView *imageV= [[UIImageView alloc] initWithFrame:self.view.bounds];
    //    imageV.image = [UIImage imageNamed:@"view_bg"];
    //    [self.view addSubview:imageV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    if (_statusBarStyle != statusBarStyle) {
        _statusBarStyle = statusBarStyle;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

@end
