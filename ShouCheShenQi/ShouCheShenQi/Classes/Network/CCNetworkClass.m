//
//  CCNetworkClass.m
//  ShouCheShenQi
//
//  Created by mac on 2016/11/4.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import "CCNetworkClass.h"
#import <Reachability.h>

static Reachability *_reach;
@implementation CCNetworkClass

+ (instancetype)shared{
    static CCNetworkClass *net = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        net = [[CCNetworkClass alloc] initWithBaseURL:[NSURL URLWithString:HostIp]];
        _reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
        [_reach startNotifier];
        //        sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //        [LYHTTPClient client];
        //        sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        //        sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        //        sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    });
    return net;
}

-(BOOL)hasNetwork{
    return _reach.isReachable;
}

- (void)getWithUrlString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                complish:(void (^)(id responseObject, NSError *error))complish{

    [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complish(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complish(nil, error);
    }];
}

- (void)postWithUrlString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                 complish:(void (^)(id responseObject, NSError *error))complish{
    //设置请求headers
//        UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
//        NSString *str1 = [NSString stringWithFormat:@"token:%@&url:/%@&timestamp:%llu&secret_key:gogen_secret_key_0000",@"5ccd319e-b4a5-cc83-a983-3fc8f481cca5",URLString,recordTime];
//        [self.requestSerializer setValue:@"5ccd319e-b4a5-cc83-a983-3fc8f481cca5" forHTTPHeaderField:@"token"];
//        [self.requestSerializer setValue:[NSString stringWithFormat:@"%llu",recordTime] forHTTPHeaderField:@"time-stamp"];
//        [self.requestSerializer setValue:[self getMd5_32Bit_String:str1] forHTTPHeaderField:@"sign"];
    [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complish(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complish(nil, error);
    }];
}

@end
