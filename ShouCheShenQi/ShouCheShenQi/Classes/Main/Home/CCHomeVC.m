//
//  CCHomeVC.m
//  ShouCheShenQi
//
//  Created by mac on 2016/11/4.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import "CCHomeVC.h"
#import "CCBaseModel.h"
@interface CCHomeVC ()

@end

@implementation CCHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    ÷tttttggggggggggvggfgfeeeeeeee
    [CCBaseModel postWithUrlString:@"" parameters:nil isCache:YES complish:^(id responseObject, NSError *error) {
        if (![[CCNetworkClass shared] hasNetwork]) {
            //没有网络
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
