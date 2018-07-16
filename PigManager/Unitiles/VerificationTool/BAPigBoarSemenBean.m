//
//  BAPigBoarSemenBean.m
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAPigBoarSemenBean.h"

@implementation BAPigBoarSemenBean
//各种品质判断标准
//+ (NSString *)GetQuantityLevel {
    /*采精量（0-99ML)， 品质=不合格<br />
     采精量（100-149ML)， 品质=合格<br />
     采精量(150-249ML)， 品质=良好<br />
     采精量(250ML-999ML)， 品质=优秀<br />*/

//    float value = self.F_Quantity.intValue;
//    if (value > 0 && value <= 99) {
//        return LevelTypeEnum.UnQualified.getKey();
//    } else if (value >= 100 && value <= 149) {
//        return LevelTypeEnum.Qualified.getKey();
//    } else if (value >= 150 && value <= 249) {
//        return LevelTypeEnum.Good.getKey();
//    } else
//        return LevelTypeEnum.Excellent.getKey();
//
//}


- (NSString *)GetColorLevel {
    return ([self.F_Color isEqualToString:@"正常"])?@"合格":@"不合格";
}

- (NSString *)GetSmellLevel {
    return ([self.F_Smell isEqualToString:@"正常"])?@"合格":@"不合格";
}


//- (NSString *)GetEnergyLevel {
//    /*活力(0-69%)    ,  品质=不合格<br />
//     活力(70-79%)    ,  品质=合格<br />
//     活力(80-89%)    ,  品质=良好<br />
//     活力(90-100%)    ,  品质=优秀<br />*/
//    int value = self.F_Energy.intValue;
//    if (value > 0 && value <= 69) {
//        return LevelTypeEnum.UnQualified.getKey();
//    } else if (value >= 70 && value <= 79) {
//        return LevelTypeEnum.Qualified.getKey();
//    } else if (value >= 80 && value <= 89) {
//        return LevelTypeEnum.Good.getKey();
//    } else {
//        return LevelTypeEnum.Excellent.getKey();
//    }
//}


//public String GetDenSityLevel() {
//    /*密度(0-0.7)    ,  品质=不合格<br />
//     密度(0.8-1.9)    ,  品质=合格<br />
//     密度(2.0-2.9)    ,  品质=良好<br />
//     密度(3-9.9)    ,  品质=优秀<br /> */
//    float value = this.F_DenSity;
//    if (value > 0 && value <= 0.7) {
//        return LevelTypeEnum.UnQualified.getKey();
//    } else if (value >= 0.8 && value <= 1.9) {
//        return LevelTypeEnum.Qualified.getKey();
//    } else if (value >= 2.0 && value <= 2.9) {
//        return LevelTypeEnum.Good.getKey();
//    } else
//        return LevelTypeEnum.Excellent.getKey();
//}
//
//public String GetDefomityLevel() {
//    /* 畸形率(18-100)    ,  品质=不合格<br />
//     畸形率(10-17)    ,  品质=合格<br />
//     畸形率(5-9)    ,  品质=良好<br />
//     畸形率(0-4)    ,  品质=优秀<br />*/
//    int value = this.F_Defomity;
//    if (value >= 18 && value <= 100) {
//        return LevelTypeEnum.UnQualified.getKey();
//    } else if (value >= 10 && value <= 17) {
//        return LevelTypeEnum.Qualified.getKey();
//    } else if (value >= 5 && value <= 9) {
//        return LevelTypeEnum.Good.getKey();
//    } else
//        return LevelTypeEnum.Excellent.getKey();
//}
//
//public String GetTotalLevel() {
//    String quantityLevel = GetQuantityLevel();
//    String colorLevel = GetColorLevel();
//    String semllLevel = GetSmellLevel();
//    String energyLevel = GetEnergyLevel();
//    String denSityLevel = GetDenSityLevel();
//    String defomityLevel = GetDefomityLevel();
//    List<String> results = new ArrayList<>();
//    results.add(quantityLevel);
//    results.add(colorLevel);
//    results.add(semllLevel);
//    results.add(energyLevel);
//    results.add(denSityLevel);
//    results.add(defomityLevel);
//
//    List<String> level = new ArrayList<>();
//    level.add("不合格");
//    level.add("合格");
//    level.add("良好");
//    level.add("优秀");
//    if (results.contains("不合格")) {
//        return LevelTypeEnum.UnQualified.getKey();
//    } else if (results.contains("合格")) {
//        return LevelTypeEnum.Qualified.getKey();
//    } else if (results.contains("良好")) {
//        return LevelTypeEnum.Good.getKey();
//    } else if (results.contains("优秀")) {
//        return LevelTypeEnum.Excellent.getKey();
//    }
//
//    return "合格";
//}
//
//public ArrayMap<String, Object> ToMap() {
//    ArrayMap<String, Object> data = new ArrayMap<>();
//    data.put("F_PigRecordId", this.F_PigRecordId);
//    data.put("F_Quantity", this.F_Quantity);
//    data.put("F_QuantityLevel", this.F_QuantityLevel);
//    data.put("F_Color", this.F_Color);
//    data.put("F_ColorLevel", this.F_ColorLevel);
//    data.put("F_Smell", this.F_Smell);
//    data.put("F_SmellLevel", this.F_SmellLevel);
//    data.put("F_Energy", this.F_Energy);
//    data.put("F_EnergyLevel", this.F_EnergyLevel);
//    data.put("F_DenSity", this.F_DenSity);
//    data.put("F_Energy", this.F_Energy);
//    data.put("F_DenSityLevel", this.F_DenSityLevel);
//    data.put("F_Defomity", this.F_Defomity);
//    data.put("F_DefomityLevel", this.F_DefomityLevel);
//    data.put("F_TotalLevel", this.F_TotalLevel);
//    data.put("F_DeluteLevel", this.F_DeluteLevel);
//    data.put("F_DeluteCount", this.F_DeluteCount);
//    data.put("F_OperatePerson", this.F_OperatePerson);
//    data.put("F_OperateTime", this.F_OperateTime);
//
//    return data;
//}
//
//
////验证数据正确性
//public Boolean Valid() {
//    //空值验证
//    if (TextUtils.isEmpty(this.F_Quantity + "") || TextUtils.isEmpty(this.F_Energy + "")
//        || TextUtils.isEmpty(this.F_DenSity + "") || TextUtils.isEmpty(this.F_Defomity + "")
//        || TextUtils.isEmpty(this.F_DeluteCount + "") || TextUtils.isEmpty(this.F_OperatePerson)) {
//        ToastUtils.showLongToast(R.string.action_cannot_empty);
//        return false;
//    }
//
//    //数字验证
//    if (!NumberUtils.isNumber(this.F_Quantity + "") || !NumberUtils.isNumber(this.F_Energy + "")
//        || !NumberUtils.isNumber(this.F_DenSity + "") || !NumberUtils.isNumber(this.F_Defomity + "")) {
//        ToastUtils.showLongToast(R.string.action_isnot_number);
//        return false;
//    }
//
//    int quantity = NumberUtils.toInt(this.F_Quantity + "", 0);
//    if (quantity < 0 || quantity > 1000) {
//        ToastUtils.showLongToast("采精量在0-1000之间");
//        return false;
//    }
//    //活力验证
//    int energy = NumberUtils.toInt(this.F_Energy + "", 0);
//    if (energy < 0 || energy > 100) {
//        ToastUtils.showLongToast("活力在0-100之间");
//        return false;
//    }
//    //密度验证
//    float denSity = NumberUtils.toFloat(this.F_DenSity + "", 0);
//    if (denSity < 0 || denSity > 10) {
//        ToastUtils.showLongToast("密度在0-10之间");
//        return false;
//    }
//
//
//
//    //稀释份数
//    int deluteCount = NumberUtils.toInt(this.F_DeluteCount + "", 0);
//    if (deluteCount < 0 || deluteCount > 100) {
//        ToastUtils.showLongToast("稀释份数在0-100之间");
//        return false;
//    }
//    return true;
//}
@end
