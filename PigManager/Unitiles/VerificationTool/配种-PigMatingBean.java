package com.pigmanager.android.bean;

import android.support.v4.util.ArrayMap;
import android.text.TextUtils;

import com.pigmanager.android.R;
import com.pigmanager.basiclib.utils.ToastUtils;

import org.apache.commons.lang3.math.NumberUtils;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by wdw on 2018/6/15.
 */

public class PigMatingBean extends BaseReponseBean<List<PigMatingBean>> implements Serializable {

    //唯一标号
    public String F_Id;
    // 猪场编号
    public String F_MerchantCode;
    //猪编号
    public String F_PigRecordId;

    // 一配时间
    public String F_OneMatingTime;
    public long oneMatingTime;

    // 一配公猪
    public String F_OneMatingBoar;

    // 二配时间
    public String F_TwoMatingTime;
    public long twoMatingTime;

    // 二配公猪
    public String F_TwoMatingBoar;

    // 预产期
    public String F_ChildTime;
    public long childMatingTime;

    // 胎龄
    public int F_ChildCount;

    // 栋舍名称
    public String F_PigHouseName;

    // 栏位
    public String F_Field;

    // 操作人
    public String F_OperatePerson;


    public ArrayMap<String, Object> ToMap(){
        ArrayMap<String, Object> data = new ArrayMap<>();
        data.put("F_PigRecordId", this.F_PigRecordId);
        data.put("F_OneMatingTime", this.F_OneMatingTime);
        data.put("F_OneMatingBoar", this.F_OneMatingBoar);
        data.put("F_TwoMatingTime", this.F_TwoMatingTime);
        data.put("F_TwoMatingBoar", this.F_TwoMatingBoar);
        data.put("F_ChildTime", this.F_ChildTime);
        data.put("F_ChildCount", this.F_ChildCount);
        data.put("F_PigHouseName", this.F_PigHouseName);
        data.put("F_Field", this.F_Field);
        data.put("F_OperatePerson", this.F_OperatePerson);

        return  data;
    }

    public Boolean Valid() {
        //一配公猪 ,责任人 不能为空 空值验证
        if (TextUtils.isEmpty(this.F_OneMatingBoar) || TextUtils.isEmpty(this.F_OperatePerson)) {
            ToastUtils.showLongToast(R.string.action_cannot_empty);
            return false;
        }

        //时间验证,不能大于当前时间
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date oneTime = format.parse(this.F_OneMatingTime);

            Date nowTime = new Date();
            if (oneTime.getTime() > nowTime.getTime()) {
                ToastUtils.showLongToast(R.string.action_time_morethennow);
                return false;
            }
            if (!TextUtils.isEmpty(this.F_TwoMatingBoar)) {
                Date twoTime = format.parse(this.F_TwoMatingTime);
                if (twoTime.getTime() > nowTime.getTime()) {
                    ToastUtils.showLongToast(R.string.action_time_morethennow);
                    return false;
                }
            }
        } catch (ParseException px) {
            px.printStackTrace();
            return false;
        }

       //胎龄验证
        int quantity = NumberUtils.toInt(this.F_ChildCount + "", 0);
        if (quantity < 0 || quantity > 15) {
            ToastUtils.showLongToast(R.string.action_PigChildCountError);
            return false;
        }

        return true;
    }
}
