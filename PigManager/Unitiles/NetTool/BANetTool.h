//
//  BANetTool.h
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define BALog(w, ... ) NSLog( @"[%@ in line %d] ===============>%@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__ , [NSString stringWithFormat:(w), ##__VA_ARGS__] )
#else
#define BALog(w, ... )
#endif

typedef NS_ENUM(NSUInteger, BAResponseType) {
    kBAResponseTypeJSON = 1, // 默认
    kBAResponseTypeXML  = 2, // xml
    // 特殊情况，一转换服务器就无法识别的，默认会尝试装换成JSON，若识别则需要自己去转换
    kBAResponseTypeData = 3
};

typedef NS_ENUM(NSUInteger, BARequestType) {
    kBARequestTypeJSON = 1, // 默认
    kBARequestTypePlainText = 2 // text/html
};

//typedef NS_ENUM(NSInteger, BANetworkStatus) {
//    kBANetworkStatusUnknown           = -1,// 未知网络
//    kBANetworkStatusNotReachable      = 0, // 没网络
//    kBANetworkStatusReachableViaWWAN  = 1, // 2G，3G，4G
//    kBANetworkStatusReachableViaWiFi  = 2  // WIFI
//};

@class NSURLSessionTask;
// 所有接口返回的类型都是基于NSURLSessionTask，若要接收返回值处理，转换成对应的子类类型
typedef NSURLSessionTask BAURLSessionTask;
typedef void(^BAResponseSuccess)(id response);
typedef void(^BAResponseError)(NSError *error);

/**
 *  基于AFNetWorking的网络层封装类
 */
@interface BANetTool : NSObject

/**
 *  用于指定网络请求接口的域名
 */
+ (void)APPUpDateBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;

/**
 *  请求超时时间，默认60秒
 */
+ (void)setTimeout:(NSTimeInterval)timeout;

/**
 *  开启或关闭接口打印信息
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/**
 *  获取缓存大小
 */
+ (unsigned long long)totalCacheSize;

/**
 *  字典转化
 */
+ (NSString *)strDic:(NSDictionary *)dic;

/**
 *  清除缓存
 */
+ (void)clearCaches;


/**
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST,请在全局配置一下
 */
+ (void)comfigRequestType:(BARequestType)requestType
             responseType:(BAResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
 callbackOnCancelRequsest:(BOOL)shouldCallbackOnCancelRequest;

/**
 *  @param httpHeaders 只需要将于服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *  取消所有请求
 */
+ (void)cancelAllRequest;


/**
 *  @param url URL,可以是绝对URL，也可以是不包括baseurl
 */
+ (void)cancelRequestWithURL:(NSString *)url;

/**
 *  GET请求接口，若不指定baseurl，可传完整的url
 *  @return 返回的对象中可取消请求的API
 */

+ (BAURLSessionTask *)getWithUrl:(NSString *)url
                         success:(BAResponseSuccess)success
                            fail:(BAResponseError)fail;

/**
 *  POST请求接口
 *  @return 返回的对象中有可能取消请求的API
 */
+ (BAURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(BAResponseSuccess)success
                             fail:(BAResponseError)fail;


/**
 *  图片上传调用方法
 */
+ (void)updataVideoWithUrl:(NSString *)url
                withParams:(NSDictionary *)params
                 withImage:(NSArray *)arrImage
    withCompressionQuality:(CGFloat)compressionQuality
                   success:(BAResponseSuccess)success
                      fail:(BAResponseError)fail;


@end
