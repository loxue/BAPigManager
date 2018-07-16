//
//  Header.h
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define WeakSelf(x)  __weak typeof(x) weakSelf = self;

//机型
#define iPhone5  ([Device isIPhone5])    //是否是IPhone5
#define iPhone6  ([Device isIPhone6])    //是否是IPhone6
#define iPhone6p ([Device isIPhone6p])   //是否是IPhone6p
#define iPhoneX  ([Device isIPhoneX])    //是否是IPhoneX
#define iOS11    ([Device isIOS11])      //是否是iOS11

//系统
#define UserDefaults     (NSUserDefaults *)[NSUserDefaults standardUserDefaults]
#define KAppDelegate     ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define KWindowWidth     ([[UIScreen mainScreen] bounds].size.width)
#define KWindowHeight    ([[UIScreen mainScreen] bounds].size.height)
#define NaviHeight iPhoneX ? 88 : 64
#define TabbarHeight iPhoneX ? 83 : 49
#define BottomHeight iPhoneX ? 34 : 0

//主屏幕
#define KWindow [UIApplication sharedApplication].keyWindow
#define kSCREEN_SCALE KWindowWidth/375

//常用字体
#define MXFont10 [UIFont systemFontOfSize:10]
#define MXFont11 [UIFont systemFontOfSize:11]
#define MXFont12 [UIFont systemFontOfSize:12]
#define MXFont13 [UIFont systemFontOfSize:13]
#define MXFont14 [UIFont systemFontOfSize:14]
#define MXFont15 [UIFont systemFontOfSize:15]
#define MXFont16 [UIFont systemFontOfSize:16]
#define MXFont17 [UIFont systemFontOfSize:17]
#define MXFont18 [UIFont systemFontOfSize:18]
#define MXFont19 [UIFont systemFontOfSize:19]
#define MXFont20 [UIFont systemFontOfSize:20]
#define MXFont(_SIZE) [UIFont systemFontOfSize:_SIZE]

#define UID                     @"uid"        //uid
#define PHOTONUM                @"photoNumber"//手机号
#define MERCHANTCODE            @"MerchantCode"//猪场编号
#define TOKEN                   @"Token"   //用户Token
#define ISLOGIN                 @"isLogin" //是否登录
#define ISADMIN                 @"IsAdmin" //0, ：超级管理员=1 有所有权限， 一般员工=0
#define POSTIDS                 @"PostIds" //防疫员工 = 1,育成员工 = 2,育肥员工 = 3,保育员工 = 4,产房员工 = 5,配怀员工 = 6"PostIds": "1,2"：意思是此员工即使防疫员工，又是育成员工


#endif /* Header_h */
