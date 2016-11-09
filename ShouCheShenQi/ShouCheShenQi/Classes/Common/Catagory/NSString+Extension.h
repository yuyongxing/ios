//
//  NSString+Extension.h
//  testProject
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGFloat)getTextWidthWithFont:(UIFont *)font;
- (CGFloat)getTextWidthWithFont:(UIFont *)font WithMaxSize:(CGSize)maxSize;

+ (NSString *)makeTextWithCount:(NSInteger)count;

- (NSDictionary *)getUrlStringParameters;

- (NSString *)md5_32;

- (NSString *)md5_16;

- (BOOL)isMobile;

@end
