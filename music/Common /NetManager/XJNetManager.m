//
//  XJNetManager.m
//  music
//
//  Created by kent on 2017/8/15.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "XJNetManager.h"
#import "AFNetworking.h"
#import "XJProgressView.h"

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
    [XJProgressView showMessage:@"LOADING...."];
   return [[self defaultManager] GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       completed(responseObject,nil);
       [XJProgressView dismiss];
       [self dictionaryToJson:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [XJProgressView dismiss];
        NSLog(@"ErrorMessage:%@",error);
       completed(nil,error);
    }];
}

/**将dic转为json的方法*/
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *abc = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",abc);
    return abc;
    
}


@end
