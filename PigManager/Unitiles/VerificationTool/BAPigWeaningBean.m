//
//  BAPigWeaningBean.m
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAPigWeaningBean.h"

@implementation BAPigWeaningBean

- (BOOL)Valid {
    //产仔不能超过25个
//    int maxChild = 25;
//    if (self.F_StandardPigCount > maxChild || self.F_BadPigCount > maxChild
//        || self.F_TotalPigCount > maxChild )
//    {
//        [KWindow makeToast:@""];
//        ToastUtils.showLongToast(R.string.action_deliverCountToMore);
//        return NO;
//    }
//    //窝总重不能超过500公斤
//    if(self.F_WeightTotal> ConfigConstants.WeaningTotalWeight)
//    {
//        ToastUtils.showLongToast(R.string.action_weaningWeightToMore);
//        return NO;
//    }
//
//    //责任人不能为空
//    if (TextUtils.isEmpty(self.F_OperatePerson))
//    {
//        ToastUtils.showLongToast(R.string.action_operate_notcanempty);
//        return NO;
//    }
//
//    //如果有效仔大于0了，总重量就不能为0
//    if(F_TotalPigCount>0 && self.F_WeightTotal==0)
//    {
//        ToastUtils.showLongToast(R.string.action_totalWeightIsZero);
//        return NO;
//    }
    
    return YES;
}

@end
