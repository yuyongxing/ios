//
//  CCBaseModel.h
//  ShouCheShenQi
//
//  Created by mac on 2016/11/4.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "CCNetworkClass.h"

typedef NS_ENUM(NSUInteger, AFRequestType) {
    AFRequestTypeGET = 0,
    AFRequestTypePOST,
};

@interface CCBaseModel : NSObject

+ (void)getWithUrlString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                 isCache:(BOOL)isCache
                complish:(void (^)(id responseObject, NSError *error))complish;
+ (void)postWithUrlString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                  isCache:(BOOL)isCache
                 complish:(void (^)(id responseObject, NSError *error))complish;
@end
