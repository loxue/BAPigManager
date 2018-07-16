package com.pigmanager.android.bean;

import android.support.v4.util.ArrayMap;
import android.text.TextUtils;

import com.pigmanager.android.R;
import com.pigmanager.android.data.ConfigConstants;
import com.pigmanager.basiclib.utils.ToastUtils;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wdw on 2018/6/15.
 */

public class PigDeliverBean extends BaseReponseBean<List<PigDeliverBean>> implements Serializable{
        //唯一标号
        public String F_Id;
        // 猪场编号
        public String F_MerchantCode;
        //猪编号
        public String F_PigRecordId ;
        // 分娩日期
        public String F_DeliverTime ;
        // 健康仔
        public Integer F_GoodPigCount ;
        // 弱仔
        public Integer F_WeakPigCount ;
        // 死胎
        public Integer F_DiePigCount ;
        // 木乃伊仔
        public Integer F_MummyPigCount ;
        // 畸形仔
        public Integer F_DeformityPigCount ;
        // 总仔数
        public Integer F_TotalPigCount ;
        // 有效仔
        public Integer F_EffectivePigCount ;
        // 胎龄
        public Integer F_ChildCount ;
        // 总重量
        public float F_WeightTotal ;
        // 平均重量
        public float F_WeightAverage ;
        // 栋舍
        public String F_PigHouseName ;
        // 栏位
        public String F_Field ;
        // 产房批次
        public String F_HouseBatch ;
        // 分娩管理员
        public String F_OperatePerson ;

        public ArrayMap<String, Object> ToMap(){
                ArrayMap<String, Object> data = new ArrayMap<>();
                data.put("F_Id", this.F_Id);
                data.put("F_PigRecordId", this.F_PigRecordId);
                data.put("F_DeliverTime", this.F_DeliverTime);
                data.put("F_GoodPigCount", this.F_GoodPigCount);
                data.put("F_WeakPigCount", this.F_WeakPigCount);
                data.put("F_DiePigCount", this.F_DiePigCount);
                data.put("F_MummyPigCount", this.F_MummyPigCount);
                data.put("F_DeformityPigCount", this.F_DeformityPigCount);
                data.put("F_TotalPigCount", this.F_TotalPigCount);
                data.put("F_EffectivePigCount", this.F_EffectivePigCount);
                data.put("F_ChildCount", this.F_ChildCount);
                data.put("F_WeightTotal", this.F_WeightTotal);
                data.put("F_WeightAverage", this.F_WeightAverage);
                data.put("F_PigHouseName", this.F_PigHouseName);
                data.put("F_Field", this.F_Field);
                data.put("F_HouseBatch", this.F_HouseBatch);
                data.put("F_OperatePerson", this.F_OperatePerson);

                return  data;
        }

        public ArrayMap<String, Object> toDeleteMap() {
                ArrayMap<String, Object> data = new ArrayMap<>();
                data.put("F_Id", this.F_Id);
                return data;
        }

        public Boolean Valid() {
                //产仔不能超过25个
                int maxChild = 25;
                if (this.F_GoodPigCount > maxChild || this.F_WeakPigCount > maxChild
                        || this.F_DiePigCount > maxChild || this.F_MummyPigCount > maxChild
                        || this.F_DeformityPigCount > maxChild || this.F_TotalPigCount > maxChild
                        || this.F_EffectivePigCount> maxChild)
                {
                        ToastUtils.showLongToast(R.string.action_deliverCountToMore);
                        return false;
                }
                //窝总重不能超过100公斤
                if(this.F_WeightTotal> ConfigConstants.DeliverTotalWeight)
                {
                        ToastUtils.showLongToast(R.string.action_deliverWeightToMore);
                        return false;
                }

                //责任人不能为空
                if (TextUtils.isEmpty(this.F_OperatePerson))
                {
                        ToastUtils.showLongToast(R.string.action_operate_notcanempty);
                        return false;
                }

                //如果有效仔大于0了，总重量就不能为0
                if(F_EffectivePigCount>0 && this.F_WeightTotal==0)
                {
                        ToastUtils.showLongToast(R.string.action_totalWeightIsZero);
                        return false;
                }

                return true;
        }
}
