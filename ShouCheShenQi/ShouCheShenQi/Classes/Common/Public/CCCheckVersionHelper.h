//
//  CCCheckVersionHelper.h
//  ShouCheShenQi
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCCheckVersionHelper : NSObject

+(CCCheckVersionHelper *)sharedInstance;

-(void)checkVersion;

@end
