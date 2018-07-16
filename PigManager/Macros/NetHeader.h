//
//  NetHeader.h
//  365
//  马彦春
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#ifndef NetHeader_h
#define NetHeader_h

#warning API调用说明：1、注册登录后获取token并保存 2、密码MD5加密

//测试地址
static NSString *const BABaseNetAddress = @"http://114.116.72.146:8001";

//预发布地址
//static NSString *const BABaseNetAddress = @"http://fastcodes.cn";

//生产地址
//static NSString *const BABaseNetAddress = @"114.116.72.146:8001";


// 注册登录接口
#define PGRegister     [NSString stringWithFormat:@"%@/user/register", BABaseNetAddress] //注册接口
#define PGLogin        [NSString stringWithFormat:@"%@/user/login", BABaseNetAddress]    //登录接口
#define PGCircleImage  [NSString stringWithFormat:@"%@/advert/GetAdverts", BABaseNetAddress] //首页轮播图接口
#define PGCreateUser        [NSString stringWithFormat:@"%@/user/createuser", BABaseNetAddress]    //老板创建员工接口（注册那个人就是老板）
#define PGGetUsers          [NSString stringWithFormat:@"%@/user/getusers", BABaseNetAddress]      //获取操作人接口
#define PGDeleteUser        [NSString stringWithFormat:@"%@/user/deleteuser", BABaseNetAddress]    //老板删除员工接口（注册那个人就是老板）

// 新增猪接口
#define PGAddNewPig    [NSString stringWithFormat:@"%@/pigrecord/Create", BABaseNetAddress]   //添加新猪接口
#define PGGetPigs      [NSString stringWithFormat:@"%@/pigrecord/GetPigs", BABaseNetAddress]  //获取猪列表接口

// 猪舍接口
#define PGUpdateFarm        [NSString stringWithFormat:@"%@/pigfarm/UpdateFarm", BABaseNetAddress]   //完善猪场信息接口
#define PGAddNewFarm        [NSString stringWithFormat:@"%@/pighouse/create", BABaseNetAddress]  //添加新猪舍接口
#define PGDeletePigFarm     [NSString stringWithFormat:@"%@/pighouse/delete", BABaseNetAddress]  //删除猪舍接口
#define PGGetPigHouses      [NSString stringWithFormat:@"%@/pighouse/GetPigHousesByType", BABaseNetAddress] //根据栋舍类别获取栋舍接口
#define PGGetPigTypeHouses  [NSString stringWithFormat:@"%@/pighouse/GetPigHousesByPigType", BABaseNetAddress] //根据猪类别获取栋舍接口

// 采精接口
#define PGGetSex       [NSString stringWithFormat:@"%@/pigboarsemen/create", BABaseNetAddress] //录入采精数据接口
#define PGModifySex    [NSString stringWithFormat:@"%@/pigboarsemen/update", BABaseNetAddress] //修改采精数据接口
#define PGDeleteSex    [NSString stringWithFormat:@"%@/pigboarsemen/Delete", BABaseNetAddress] //删除采精数据接口
#define PGPageSexData  [NSString stringWithFormat:@"%@/pigboarsemen/GetSemens", BABaseNetAddress] //分页获取采精数据接口
#define PGGetbyid      [NSString stringWithFormat:@"%@/pigboarsemen/getbyid", BABaseNetAddress]   //根据F_Id获取单条数据

// 配种接口
#define PGPigCreate     [NSString stringWithFormat:@"%@/pigmating/create", BABaseNetAddress] //配种数据录入接口
#define PGPigUpdate     [NSString stringWithFormat:@"%@/pigmating/update", BABaseNetAddress] //修改配种数据接口
#define PGPigDelete     [NSString stringWithFormat:@"%@/pigmating/delete", BABaseNetAddress] //删除采精数据接口
#define PGPigGetmatings [NSString stringWithFormat:@"%@/pigmating/getmatings", BABaseNetAddress] //分页获取配种数据接口

// 孕检接口
#define PGPigPregnancyTest               [NSString stringWithFormat:@"%@/checking/create", BABaseNetAddress] //孕检数据录入接口
#define PGPigModifyPregnancyTestData     [NSString stringWithFormat:@"%@/checking/update", BABaseNetAddress] //修改孕检数据接口
#define PGPigDeletePregnancyTestData     [NSString stringWithFormat:@"%@/checking/delete", BABaseNetAddress] //删除孕检数据接口
#define PGPigGetchecksPregnancyTestData  [NSString stringWithFormat:@"%@/checking/getchecks", BABaseNetAddress] //分页获取孕检数据接口

// 分娩接口
#define PGPigChildbirth           [NSString stringWithFormat:@"%@/deliver/create", BABaseNetAddress] //分娩数据录入接口
#define PGPigChildbirthUpdate     [NSString stringWithFormat:@"%@/deliver/update", BABaseNetAddress] //修改分娩数据接口
#define PGPigChildbirthDelete     [NSString stringWithFormat:@"%@/deliver/delete", BABaseNetAddress] //删除分娩数据接口
#define PGPigChildbirthGetmatings [NSString stringWithFormat:@"%@/deliver/getdelivers", BABaseNetAddress] //分页获取分娩数据接口

// 死淘接口
#define PGPigDeathElimination           [NSString stringWithFormat:@"%@/dieout/create", BABaseNetAddress] //死淘数据录入接口
#define PGPigDeathEliminationUpdate     [NSString stringWithFormat:@"%@/dieout/update", BABaseNetAddress] //修改死淘数据接口
#define PGPigDeathEliminationGetmatings [NSString stringWithFormat:@"%@/dieout/getdieouts", BABaseNetAddress] //分页获取死淘数据接口

// 疫苗接口
#define PGPigVaccineCreate           [NSString stringWithFormat:@"%@/vaccine/create", BABaseNetAddress] //添加疫苗接口
#define PGPigVaccineDelete           [NSString stringWithFormat:@"%@/vaccine/delete", BABaseNetAddress] //删除自定义疫苗接口
#define PGPigVaccineGetvaccines      [NSString stringWithFormat:@"%@/vaccine/getvaccines", BABaseNetAddress] //获取疫苗列表接口
#define PGPigVaccineChoose           [NSString stringWithFormat:@"%@/vaccine/choose", BABaseNetAddress] //选择系统疫苗接口
#define PGPigVaccineCancleChoose     [NSString stringWithFormat:@"%@/vaccine/canclechoose", BABaseNetAddress] //取消选择系统疫苗接口

// H5接口
#define PGModifySystemParam     [NSString stringWithFormat:@"%@/sysconfig/update", BABaseNetAddress] //修改系统参数设置接口
#define PGGetSystemParam        [NSString stringWithFormat:@"%@/sysconfig/get", BABaseNetAddress] //获取系统参数设置接口

#endif /* NetHeader_h */
