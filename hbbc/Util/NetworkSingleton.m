//
//  NerworkSingleton.m
//  demoapp
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 handbbc. All rights reserved.
//

#import "NetworkSingleton.h"

@implementation NetworkSingleton

+ (NetworkSingleton *)shareManager
{
    static NetworkSingleton *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedNetworkSingleton = [[self alloc] init];
    });
    return sharedNetworkSingleton;
}



- (BOOL)isConnectionAvailable
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
    if (!manager.isReachable) {
        return NO;
    }
    return YES;
}



- (void)httpRequest:(NSDictionary *)userInfo url:(NSString *)url success:(SuccessBlock)successblock failed:(FailureBlock)failureblock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [manager POST:url parameters:userInfo success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureblock(error);
    }];

}



- (AFHTTPRequestOperation *)downLoadFile:(NSDictionary *)UserInfo url:(NSString *)url withName:(NSString *)Name
{
    return nil;
}
@end
