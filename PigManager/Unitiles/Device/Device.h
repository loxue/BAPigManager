//
//  Device.h
//  XGCaiHang
//  马彦春
//  Created by CoreJJ on 14-7-12.
//  Copyright (c) 2014年 Beijing Dnurse Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const Device_OSVer;
extern NSString *const Device_UserSN;
extern NSString *const Device_Brand;
extern NSString *const Device_Model;
extern NSString *const Device_Softver;

@interface

Device : NSObject

+ (NSString *)generateUUID;

+ (CGFloat)getSystemVersion;

+ (NSString *)getDevicePlatform;//硬件型号

+ (NSString *)getCurrentDate;

+ (NSString *)getAPPVersion;//app version

+ (NSString *)getBundleVersion;//app build

//+ (NSString *)getIdfa;//idfa

+ (NSString *)getIdfv;//idfv

+ (BOOL)afterIOS7;

+ (BOOL)isIOS7;

+ (BOOL)isIOS8;

+ (BOOL)isIOS9;

+ (BOOL)isIOS11;

+ (BOOL)isIPhone4;

+ (BOOL)isIPhone5;

+ (BOOL)isIPhone6;

+ (BOOL)isIPhone6p;

+ (BOOL)isIPhoneX;

@end
