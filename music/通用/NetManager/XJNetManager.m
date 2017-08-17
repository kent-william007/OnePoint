//
//  XJNetManager.m
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJNetManager.h"
#import "AFNetworking.h"
@implementation XJNetManager
+ (AFHTTPSessionManager *)defaultManager{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager;
    dispatch_once(&onceToken,^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/plain",@"text/javascript",@"application/json", nil];
        
    });
    return manager;
}

+ (id)GET:(NSString *)path paramaters:(NSDictionary *)params complationHandle:(void (^)(id, NSError *))completed{
   return [[self defaultManager] GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       completed(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       completed(nil,error);
    }];
}

@end
