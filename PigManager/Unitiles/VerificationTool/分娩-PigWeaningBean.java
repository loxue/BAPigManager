package com.pigmanager.android.bean;

import android.support.v4.util.ArrayMap;
import android.text.TextUtils;

import com.pigmanager.android.R;
import com.pigmanager.android.data.ConfigConstants;
import com.pigmanager.basiclib.utils.ToastUtils;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by wdw on 2018/6/15.
 */

public class PigWeaningBean extends BaseReponseBean<List<PigWeaningBean>> implements Serializable {
    //唯一标号
    public String F_Id;
    // 猪场编号
    public String F_MerchantCode;
    //猪编号
    public String F_PigRecordId;
    // 断奶日期
    public String F_WeaningTime;
    // 合格仔
    public Integer F_StandardPigCount;
    // 次品仔
    public Integer F_BadPigCount;
    // 总仔数
    public Integer F_TotalPigCount;
    // 胎龄
    public Integer F_ChildCount;
    /// 窝总重
    public float F_WeightTotal;
    // 窝均重
    public float F_WeightAverage;
    // 断奶栋舍
    public String F_PigHouseName;
    // 断奶栏位
    public String F_Field;
    // 断奶管理员
    public String F_OperatePerson;

    public ArrayMap<String, Object> ToMap(){
        ArrayMap<String, Object> data = new ArrayMap<>();
        data.put("F_Id", this.F_Id);
        data.put("F_PigRecordId", this.F_PigRecordId);
        data.put("F_WeaningTime", this.F_WeaningTime);
        data.put("F_StandardPigCount", this.F_StandardPigCount);
        data.put("F_BadPigCount", this.F_BadPigCount);
        data.put("F_TotalPigCount", this.F_TotalPigCount);
        data.put("F_ChildCount", this.F_ChildCount);
        data.put("F_WeightTotal", this.F_WeightTotal);
        data.put("F_WeightAverage", this.F_WeightAverage);
        data.put("F_PigHouseName", this.F_PigHouseName);
        data.put("F_Field", this.F_Field);
        data.put("F_OperatePerson", this.F_OperatePerson);

        return  data;
    }

    public ArrayMap<String, Object> toDeleteMap() {
        ArrayMap<String, Object> data = new ArrayMap<>();
        data.put("F_Id", this.F_Id);
        return data;
    }

    public boolean Valid() {
        //产仔不能超过25个
        int maxChild = 25;
        if (this.F_StandardPigCount > maxChild || this.F_BadPigCount > maxChild
                || this.F_TotalPigCount > maxChild )
        {
            ToastUtils.showLongToast(R.string.action_deliverCountToMore);
            return false;
        }
        //窝总重不能超过500公斤
        if(this.F_WeightTotal> ConfigConstants.WeaningTotalWeight)
        {
            ToastUtils.showLongToast(R.string.action_weaningWeightToMore);
            return false;
        }

        //责任人不能为空
        if (TextUtils.isEmpty(this.F_OperatePerson))
        {
            ToastUtils.showLongToast(R.string.action_operate_notcanempty);
            return false;
        }

        //如果有效仔大于0了，总重量就不能为0
        if(F_TotalPigCount>0 && this.F_WeightTotal==0)
        {
            ToastUtils.showLongToast(R.string.action_totalWeightIsZero);
            return false;
        }

        return true;
    }
}
