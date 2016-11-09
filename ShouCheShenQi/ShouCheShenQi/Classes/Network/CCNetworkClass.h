//
//  CCNetworkClass.h
//  ShouCheShenQi
//
//  Created by mac on 2016/11/4.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CCNetworkClass : AFHTTPSessionManager

+ (instancetype)shared;

- (BOOL)hasNetwork;

- (void)getWithUrlString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                complish:(void (^)(id responseObject, NSError *error))complish;
- (void)postWithUrlString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                 complish:(void (^)(id responseObject, NSError *error))complish;


@end
