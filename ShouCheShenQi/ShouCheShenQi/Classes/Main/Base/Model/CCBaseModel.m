//
//  CCBaseModel.m
//  ShouCheShenQi
//
//  Created by mac on 2016/11/4.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import "CCBaseModel.h"
#import <YYCache.h>

static NSString * const YYRequestCache = @"YYRequestCache";

@implementation CCBaseModel

MJCodingImplementation

+(void)getWithUrlString:(NSString *)URLString parameters:(NSDictionary *)parameters isCache:(BOOL)isCache complish:(void (^)(id responseObject, NSError *error))complish{
    
    [self requestMethod:AFRequestTypeGET urlString:URLString parameters:parameters isCache:isCache complish:complish];
}

+(void)postWithUrlString:(NSString *)URLString parameters:(NSDictionary *)parameters isCache:(BOOL)isCache complish:(void (^)(id responseObject, NSError *error))complish{
    
    [self requestMethod:AFRequestTypePOST urlString:URLString parameters:parameters isCache:isCache complish:complish];
}

+ (void)requestMethod:(AFRequestType)type
            urlString:(NSString *)URLString
           parameters:(NSDictionary *)parameters
              isCache:(BOOL)isCache
             complish:(void (^)(id responseObject, NSError *error))complish{
    
    CCNetworkClass *networkClass = [CCNetworkClass shared];
    
    YYCache *cache = [[YYCache alloc] initWithName:YYRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    
    id object = [cache objectForKey:URLString];
    
    if (isCache) {
        if (object) complish(object,nil);
    }
    
    //没有网络直接reture
    if (![networkClass hasNetwork]) {
        complish(object,nil);
        return;
    }
    
    switch (type) {
        case AFRequestTypeGET:{
            [networkClass getWithUrlString:URLString parameters:parameters complish:^(id responseObject, NSError *error) {
                if (responseObject) {
                    id result = [[self class] mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                    
                    complish(result,nil);
                    if (isCache) {
                        [cache setObject:result forKey:URLString];
                    }
                }else{
                    complish(nil,error);
                }
                
            }];
            
            break;
        }
        case AFRequestTypePOST:{
            [networkClass postWithUrlString:URLString parameters:parameters complish:^(id responseObject, NSError *error) {
                if (responseObject) {
                    id result = [[self class] mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                    
                    complish(result,nil);
                    if (isCache) {
                        [cache setObject:result forKey:URLString];
                    }
                }else{
                    complish(nil,error);
                }
            }];
            
            break;
        }
        default:
            break;
    }
}
@end
