package com.pigmanager.android.bean;

import android.support.v4.util.ArrayMap;
import android.text.TextUtils;

import com.pigmanager.android.R;
import com.pigmanager.basiclib.utils.ToastUtils;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wdw on 2018/6/15.
 */

public class PigCheckingBean extends BaseReponseBean<List<PigCheckingBean>> implements Serializable {

    //唯一标号
    public String F_Id;
    // 猪场编号
    public String F_MerchantCode;
    //猪编号
    public String F_PigRecordId;
    // 孕检原因
    public String F_CheckReason;
    // 孕检结果
    public String F_CheckResult;
    //胎龄
    public int F_ChildCount;
    // 栋舍
    public String F_PigHouseName;
    // 栏位
    public String F_Field;
    /// 操作人
    public String F_OperatePerson;
    // 操作日期
    public String F_OperateTime;

    public ArrayMap<String, Object> ToMap() {
        ArrayMap<String, Object> data = new ArrayMap<>();
        data.put("F_PigRecordId", this.F_PigRecordId);
        data.put("F_CheckReason", this.F_CheckReason);
        data.put("F_CheckResult", this.F_CheckResult);
        data.put("F_ChildCount", this.F_ChildCount);
        data.put("F_PigHouseName", this.F_PigHouseName);
        data.put("F_Field", this.F_Field);
        data.put("F_OperatePerson", this.F_OperatePerson);
        data.put("F_OperateTime", this.F_OperateTime);

        return data;
    }

    public ArrayMap<String, Object> toDeleteMap() {
        ArrayMap<String, Object> data = new ArrayMap<>();
        data.put("F_Id", this.F_Id);
        return data;
    }


    public Boolean Valid() {
        //空值验证
        if (TextUtils.isEmpty(this.F_OperatePerson)) {
            ToastUtils.showLongToast(R.string.action_operate_notcanempty);
            return false;
        }

        return true;
    }
}
