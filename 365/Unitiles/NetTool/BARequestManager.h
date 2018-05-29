//
//  BARequestManager.h
//  365
//
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BABaseResponse.h"
#import <AFNetworking.h>

typedef enum : NSInteger {
    BARequestManagerStatusCodeCustomDemo = -10000,
} BARequestManagerStatusCode;

typedef BABaseResponse *(^ResponseFormat)(BABaseResponse *response);
typedef void(^PPRequestSuccess)(id response);
typedef void(^PPRequestFailure)(NSError *error);

@interface BARequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

+ (NSURLSessionTask *)postRequestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(PPRequestSuccess)success failure:(PPRequestFailure)failure;

+ (NSURLSessionTask *)getRequestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(PPRequestSuccess)success failure:(PPRequestFailure)failure;

//本地数据模式
@property (assign, nonatomic) BOOL isLocal;

//预处理返回的数据
@property (copy, nonatomic) ResponseFormat responseFormat;

- (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void (^)(BABaseResponse *response))completion;
- (void)GET:(NSString *)urlString parameters:(id)parameters completion:(void (^)(BABaseResponse *response))completion;

/**
 data 对应的二进制数据
 name 服务端需要参数
 */
- (void)upload:(NSString *)urlString parameters:(id)parameters formDataBlock:(void(^)(id<AFMultipartFormData> formData))formDataBlock progress:(void (^)(NSProgress *progress))progress completion:(void (^)(BABaseResponse *response))completion;


@end
