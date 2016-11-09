//
//  UIBarButtonItem+Extension.m
//  testProject
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)barButtonItemWithImage:(NSString *)image
                            pressImage:(NSString *)pressImage
                                target:(id)target action:(SEL)action
{
    return [[[self class] alloc] initWithImage:image pressImage:pressImage target:target action:action];
}
- (instancetype)initWithImage:(NSString *)image
                   pressImage:(NSString *)pressImage
                       target:(id)target action:(SEL)action
{
    
    UIButton *btn = [UIButton new];
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:pressImage] forState:UIControlStateSelected];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn sizeToFit];
    
    return [self initWithCustomView:btn];
}

@end
