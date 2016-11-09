//
//  UIBarButtonItem+Extension.h
//  testProject
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)barButtonItemWithImage:(NSString *)image
                            pressImage:(NSString *)pressImage
                                target:(id)target action:(SEL)action;

- (instancetype)initWithImage:(NSString *)image
                   pressImage:(NSString *)pressImage
                       target:(id)target action:(SEL)action;

@end
