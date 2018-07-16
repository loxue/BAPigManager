//
//  BANetTool.m
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BANetTool.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

+ (NSString *)BANetTool_MD5:(NSString *)string;

@end

@implementation NSString (MD5)

+ (NSString *)BANetTool_MD5:(NSString *)string {
    if(string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding],digest);
    NSMutableString *MD5 = [NSMutableString string];
    for (int i = 0 ; i < CC_MD5_DIGEST_LENGTH; i++) {
        [MD5 appendFormat:@"%02x",(int)(digest[i])];
    }
    return [MD5 copy];
}

@end


static NSString *ba_privateNetworkBaseUrl = nil;
static BOOL ba_isEnableInterfaceDebug = NO;
static BOOL ba_shouldAutoEncode = NO;
static NSDictionary *ba_httpHeaders = nil;
static BAResponseType ba_responseType = kBAResponseTypeJSON;
static BARequestType ba_requestType = kBARequestTypeJSON;
//static BANetworkStatus ba_networkStatus = kBANetworkStatusUnknown;
static NSMutableArray *ba_requestTasks;
static BOOL ba_cacheGet = YES;
static BOOL ba_cachePost = NO;
static BOOL ba_shouldCallbackOnCancelRequest = YES;
static NSTimeInterval ba_timeout = 60.0f;
static BOOL ba_shoulObtainLocalWhenUnconnected = NO;


@implementation BANetTool

/**
 *  用于指定网络请求接口的域名,
 *  通常在AppDelegate中启动时就设置一次就可以了，如果接口有来源于多个服务器，可以调用更新
 *
 *  @param baseUrl 网络请求的域名
 */
+ (void)APPUpDateBaseUrl:(NSString *)baseUrl {
    ba_privateNetworkBaseUrl = baseUrl;
}
+ (NSString *)baseUrl {
    return ba_privateNetworkBaseUrl;
}

/**
 *  请求超时时间，默认60秒
 *
 *  @param timeout 超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout {
    ba_timeout = timeout;
}

/**
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期，最好打开 ,默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug {
    ba_isEnableInterfaceDebug = isDebug;
}

+ (BOOL)isDebug {
    return ba_isEnableInterfaceDebug;
}

static inline NSString *cachePath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/BANetToolCaches"];
}

/**
 *  清空缓存
 */
+ (void)clearCaches {
    NSString *directoryPath = cachePath();
    
    if([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
        
        if(error) {
            BALog(@"BANetToll clear caches error: %@", error);
        } else {
            BALog(@"BANetToll clear caches ok");
        }
        
    }
}

+ (unsigned long long)totalCacheSize {
    NSString *directoryPath = cachePath();
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;
}


/**
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST,请在全局配置一下
 *
 *  @param requestType                   请求格式，默认为JSON
 *  @param responseType                  响应格式，默认为JSON
 *  @param shouldAutoEncode              默认为NO，是否自动encodeurl
 *  @param shouldCallbackOnCancelRequest 当取消请求时，是否要回调，默认为YES
 */
+ (void)comfigRequestType:(BARequestType)requestType
             responseType:(BAResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
 callbackOnCancelRequsest:(BOOL)shouldCallbackOnCancelRequest
{
    
    ba_requestType = requestType;
    ba_responseType = responseType;
    ba_shouldAutoEncode = shouldAutoEncode;
    ba_shouldCallbackOnCancelRequest = shouldCallbackOnCancelRequest;

}

+ (BOOL)shouldEncode {
    return ba_shouldAutoEncode;
}

/**
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将于服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders {
    ba_httpHeaders = httpHeaders;
}

+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(ba_requestTasks == nil){
            ba_requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return ba_requestTasks;
}

/**
 *
 *  取消所有请求
 */
+ (void)cancelAllRequest {
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(BAURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if([task isKindOfClass:[BAURLSessionTask class]]){
                [task cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    };
}


/**
 *  取消某个网络请求，如果是要取消某个请求，最好是引用接口所返回来的BAURLSessionTask对象
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供一种方法来实现取消某个请求
 *
 *  @param url URL,可以是绝对URL，也可以是不包括baseurl
 */
+ (void)cancelRequestWithURL:(NSString *)url {
    if(url == nil) {
        return;
    }
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(BAURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if([task isKindOfClass:[BAURLSessionTask class]] && [task.currentRequest.URL.absoluteString hasSuffix:url]){
                [task cancel];
                [[self allTasks] removeObject:task];
                return ;
            }
        }];
    };
}

/**
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中可取消请求的API
 */

+ (BAURLSessionTask *)getWithUrl:(NSString *)url success:(BAResponseSuccess)success fail:(BAResponseError)fail {
    return [self ba_requestWithUrl:url refreshCache:NO httpMedth:1 params:nil success:success fail:fail];
}

/**
 *  POST请求接口
 *
 *  @param url     接口路径
 *  @param params  接口所需的参数
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可能取消请求的API
 */
+ (BAURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(BAResponseSuccess)success
                             fail:(BAResponseError)fail
{
    return  [self ba_requestWithUrl:url refreshCache:NO httpMedth:2 params:params success:success fail:fail];
}




/**
 *  上传多张图片 (Data模式)
 *
 *  @param url                上传地址
 *  @param params             上传附带参数
 *  @param arrImage           上传Image数组
 *  @param compressionQuality 压缩比例
 *  @param success            请求成功
 *  @param fail               请求失败
 */
+ (void)updataVideoWithUrl:(NSString *)url
                withParams:(NSDictionary *)params
                 withImage:(NSArray *)arrImage
    withCompressionQuality:(CGFloat)compressionQuality
                   success:(BAResponseSuccess)success
                      fail:(BAResponseError)fail
{
    //检查参数是否正确
    if (!url|| !arrImage) {
        NSLog(@"参数不完整");
        return;
    }
    if ([url rangeOfString:@"http://"].location == NSNotFound) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    //初始化
    NSString *hyphens = @"--";
    NSString *boundary = @"--------boundary";
    NSString *end = @"\r\n";
    //初始化数据
    NSMutableData *myRequestData1=[NSMutableData data];
    //    //参数的集合的所有key的集合
    //    NSArray *keys= [params allKeys];
    //
    //    //添加其他参数
    //    for(int i = 0;i < [keys count];i ++)
    //    {
    //        NSMutableString *body = [[NSMutableString alloc]init];
    //        [body appendString:hyphens];
    //        [body appendString:boundary];
    //        [body appendString:end];
    //        //得到当前key
    //        NSString *key = [keys objectAtIndex:i];
    //        //添加字段名称
    //        [body appendFormat:@"Content-Disposition: form-data; %@%@",end,end];
    //
    //        //添加字段的值
    //        [body appendFormat:@"%@",[params objectForKey:key]];
    //        [body appendString:end];
    //        [myRequestData1 appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //        NSLog(@"添加字段的值==%@",[params objectForKey:key]);
    //    }
    //添加图片资源
    for (int i = 0; i < arrImage.count; i++) {
        if (![arrImage[i] isKindOfClass:[UIImage class]]) {
            return;
        }
        //获取资源
        UIImage *image = arrImage[i];
        //得到图片的data
        NSData* data = UIImageJPEGRepresentation(image,compressionQuality);
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        //所有字段的拼接都不能缺少，要保证格式正确
        [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        NSMutableString *fileTitle=[[NSMutableString alloc]init];
        //要上传的文件名和key，服务器端接收
        [fileTitle appendFormat:@"Content-Disposition: form-data; name=\"upload_file%d\"; filename=\"file%u.jpg\"",i,i];
        [fileTitle appendString:end];
        [fileTitle appendString:[NSString stringWithFormat:@"Content-Type: image/jpeg%@",end]];
        [fileTitle appendString:end];
        [myRequestData1 appendData:[fileTitle dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:data];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    //    [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
    //    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //添加其他参数
    for(int i = 0;i < [keys count];i ++) {
        NSMutableString *body = [[NSMutableString alloc]init];
        [body appendString:hyphens];
        [body appendString:boundary];
        [body appendString:end];
        //得到当前key
        NSString *key = [keys objectAtIndex:i];
        //添加字段名称
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"%@%@",key,end,end];
        
        //添加字段的值
        [body appendFormat:@"%@",[params objectForKey:key]];
        [body appendString:end];
        [myRequestData1 appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"添加字段的值==%@",[params objectForKey:key]);
    }
    
    //拼接结束~~~
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data;boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData1 length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData1];
    //http method
    [request setHTTPMethod:@"POST"];
    //回调返回值
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (fail) {
                    //出现任何服务器端返回的错误，交给block处理
                    [self handleCallbackWithError:connectionError fail:fail];
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 尝试解析成JSON
                NSError *error = nil;
                NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
                if(error != nil) {
                    if (fail) {
                        //出现任何服务器端返回的错误，交给block处理
                        [self handleCallbackWithError:connectionError fail:fail];
                    }
                } else {
                    if (success) {
                        [self successResponse:response callback:success];
                    }
                }
            });
        }
    }];
}

/**
 *  <#Description#>
 *
 *  @param url          请求网络路径
 *  @param refreshCache 是否 缓存
 *  @param httpMethod   模式 GET 还是 POST
 *  @param params       附带的参数
 *  @param success      请求成功
 *  @param fail         请求失败
 *
 *  @return <#return value description#>
 */
+ (BAURLSessionTask *)ba_requestWithUrl:(NSString *)url
                            refreshCache:(BOOL)refreshCache
                               httpMedth:(NSUInteger)httpMethod
                                  params:(NSDictionary *)params
                                 success:(BAResponseSuccess)success
                                    fail:(BAResponseError)fail
{
    refreshCache = YES;
    
    AFHTTPSessionManager *manager = [self manager];
    NSString *absolute = [self absoluteUrlWithPath:url];
    
    if([self baseUrl] == nil) {
        if([NSURL URLWithString:url] == nil) {
            BALog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        NSURL *absouluteURL = [NSURL URLWithString:absolute];
        
        if(absouluteURL == nil) {
            BALog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    
    if([self shouldEncode]) {
        url = [self encodeUrl:url];
    }
    
    BAURLSessionTask *session = nil;
    
    if(httpMethod == 1) {
        if(ba_cacheGet)  {
            if(ba_shoulObtainLocalWhenUnconnected) {
//                if(ba_networkStatus == kBANetworkStatusNotReachable || ba_networkStatus == kBANetworkStatusUnknown) {
                    id response = [BANetTool cahceResponseWithURL:absolute parameters:params];
                    
                    if(response) {
                        if(success)  {
                            [self successResponse:response callback:success];
                            
                            if([self isDebug]) {
                                [self logWithSuccessResponse:response url: absolute params: params];
                            }
                        }
                        return nil;
                    }
//                }
            }
            
            if(!refreshCache) {
                // 获取缓存
                id response = [BANetTool cahceResponseWithURL:absolute parameters:params];
                
                if(response) {
                    if(success) {
                        [self successResponse:response callback:success];
                        
                        if([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                    return nil;
                }
            }
        }
        
        session = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
          
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            
            if (ba_cacheGet) {
                [self cacheResponseObject:responseObject request:task.currentRequest parameters:params];
            }
            
            [[self allTasks] removeObject:task];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:absolute
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self allTasks] removeObject:task];
            
            if ([error code] < 0 && ba_cacheGet) {// 获取缓存
                id response = [BANetTool cahceResponseWithURL:absolute
                                                       parameters:params];
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                } else {
                    [self handleCallbackWithError:error fail:fail];
                    
                    if ([self isDebug]) {
                        [self logWithFailError:error url:absolute params:params];
                    }
                }
            } else {
                [self handleCallbackWithError:error fail:fail];
                
                if ([self isDebug]) {
                    [self logWithFailError:error url:absolute params:params];
                }
            }
        }];
    } else if (httpMethod == 2) {
        // 获取缓存
        if(ba_cachePost) {
            if(ba_shoulObtainLocalWhenUnconnected) {
//                if(ba_networkStatus == kBANetworkStatusNotReachable || ba_networkStatus == kBANetworkStatusUnknown) {
                    id response = [BANetTool cahceResponseWithURL:absolute parameters:params];
                    if(response) {
                        if(success) {
                            [self successResponse:response callback:success];
                            
                            if([self isDebug]) {
                                [self logWithSuccessResponse:response url:absolute params:params];
                            }
                        }
                        return nil;
                    }
//                }
            }
            if (!refreshCache)  {
                id response = [BANetTool cahceResponseWithURL:absolute parameters:params];
                if(response) {
                    if(success) {
                        [self successResponse:response callback:success];
                        if([self isDebug]) {
                            [self logWithSuccessResponse:response url:absolute params:params];
                        }
                    }
                    return nil;
                }
            }
        }
        
        session = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self successResponse:responseObject callback:success];
            
            if(ba_cachePost) {
                [self cacheResponseObject:responseObject request:task.currentRequest parameters:params];
            }
            
            [[self allTasks] removeObject:task];
            
            if([self isDebug]) {
                [self logWithSuccessResponse:responseObject url:absolute params:params];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
            [[self allTasks] removeObject:task];
            
            if([error code] < 0 && ba_cachePost) {
                // 获取缓存
                id response = [BANetTool cahceResponseWithURL:absolute parameters:params];
                
                if(response) {
                    if(success) {
                        [self successResponse:response callback:success];
                        
                        if([self isDebug]) {
                            [self logWithSuccessResponse:response url:absolute params:params];
                        }
                    }
                } else {
                    [self handleCallbackWithError:error fail:fail];
                    
                    if ([self isDebug]) {
                        [self logWithFailError:error url:absolute params:params];
                    }
                }
            } else {
                [self handleCallbackWithError:error fail:fail];
                
                if([self isDebug]) {
                    [self logWithFailError:error url:absolute params:params];
                }
            }
        }];
    }
    
    if(session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

#pragma mark - Private
+ (AFHTTPSessionManager *)manager {
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = nil;
    if([self baseUrl] != nil) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    } else {
        manager = [AFHTTPSessionManager manager];
    }
    
    switch (ba_requestType) {
        case kBARequestTypeJSON:{
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
              break;
        }
        case kBARequestTypePlainText:{
            
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
             break;
        }
        default:{
            break;
        }
    }
    
    switch (ba_responseType) {
        case kBAResponseTypeJSON:{
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case kBAResponseTypeXML:{
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case kBAResponseTypeData:{
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        default:
            break;
    }
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    for(NSString *key in ba_httpHeaders.allKeys) {
        if(ba_httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:ba_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    manager.requestSerializer.timeoutInterval = ba_timeout;
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    if(ba_shoulObtainLocalWhenUnconnected  && (ba_cacheGet || ba_cachePost) ) {
        [self detectNetwork];
    }
    return manager;
}

+ (void)detectNetwork {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if(status == AFNetworkReachabilityStatusNotReachable) {
//            ba_networkStatus = kBANetworkStatusNotReachable;
//        } else if (status == AFNetworkReachabilityStatusUnknown) {
//            ba_networkStatus = kBANetworkStatusUnknown;
//        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
//            ba_networkStatus = kBANetworkStatusReachableViaWWAN;
//        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
//            ba_networkStatus = kBANetworkStatusReachableViaWiFi;
//        }
    }];
}

+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if(path == nil || path.length == 0) {
        return @"";
    }
    
    if([self baseUrl] == nil || [[self baseUrl] length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if(![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        if([[self baseUrl] hasSuffix:@"/"])  {
            if([path hasPrefix:@"/"]) {
                NSMutableString *mutablePath = [NSMutableString stringWithString:path];
                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl],mutablePath];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl],path];
            }
            
        } else {
            if([path hasPrefix:@"/"]) {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@/%@",[self baseUrl] ,path];
            }
        }
    }
    
    return  absoluteUrl;
}


+ (NSString *)encodeUrl:(NSString *)url {
    return [self wzx_URLEncode:url];
}

+ (NSString *)wzx_URLEncode:(NSString *)url {
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if(newString) {
        return newString;
    }
    return url;
}

+ (id)cahceResponseWithURL:(NSString *)url parameters:(id)params {
    id cacheData = nil;
    
    if(url) {
        NSString *directoryPath = cachePath();
        NSString*absoluteURL = [self generateGETAbsoluteURL:url params:params];
        NSString *key = [NSString BANetTool_MD5:absoluteURL];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
        if(data) {
            cacheData =data;
            BALog(@"从缓存中读取URL数据: %@\n", url);
        }
    }
    
    return cacheData;
}

// 对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params {
    if(params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] ==0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",(queries.length == 0 ? @"&" : queries),key,value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length-1];
    }
    
    if(([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if([url rangeOfString:@"?"].location != NSNotFound || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@",url,queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@",url,queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}

+ (NSString *)strDic:(NSDictionary *)dic {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (void)successResponse:(id)responseData callback:(BAResponseSuccess)success {
    if(success) {
        success([self tryToParseData:responseData]);
    }
}

+ (id)tryToParseData:(id)responseData {
    if([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if(responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            
            if(error != nil) {
                return responseData;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    BALog(@"\n");
    BALog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",
           [self generateGETAbsoluteURL:url params:params],
           params,
           [self tryToParseData:response]);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(id)params {
    NSString *format = @" params: ";
    if(params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        format = @"";
        params = @"";
    }
    
    BALog(@"\n");
    if([error code] == NSURLErrorCancelled) {
        BALog(@"\nRequest was canceled mannully, URL: %@ %@%@\n\n",
               [self generateGETAbsoluteURL:url params:params],
               format,
               params);
    } else {
        BALog(@"\nRequest error, URL: %@ %@%@\n errorInfos:%@\n\n",
                  [self generateGETAbsoluteURL:url params:params],
                  format,
                  params,
                  [error localizedDescription]);
    }
}


+ (void)cacheResponseObject:(id)responseObject request:(NSURLRequest *)request parameters:(id)params {
    if(request && responseObject && ![responseObject isKindOfClass:[NSNull class]]) {
        NSString *directoryPath = cachePath();
        NSError *error = nil;
        if(![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
            
            if(error)  {
                BALog(@"创建缓存目录错误:%@\n",error);
                return;
            }
        }
        
        NSString *absoluteURL = [self generateGETAbsoluteURL:request.URL.absoluteString params:params];
        NSString *key = [NSString BANetTool_MD5:absoluteURL];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSData *data = nil;
        if([dict isKindOfClass:[NSData class]]) {
            data = responseObject;
        } else {
            data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        }
        
        if(data && error == nil) {
            BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
            if(isOk) {
                BALog(@"缓存文件确定: %@\n",absoluteURL);
            } else {
                BALog(@"请求缓存文件错误: %@\n",absoluteURL);
            }
        }
    }
}

+ (void)handleCallbackWithError:(NSError *)error fail:(BAResponseError)fail {
    if([error code] == NSURLErrorCancelled) {
        if(ba_shouldCallbackOnCancelRequest)  {
            if(fail) {
                fail(error);
            }
        }
    } else {
        if(fail) {
            fail(error);
        }
    }
}

@end
