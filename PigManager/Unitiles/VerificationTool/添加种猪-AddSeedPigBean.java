package com.pigmanager.android.bean;

import android.support.v4.util.ArrayMap;
import android.text.TextUtils;

import com.pigmanager.android.R;
import com.pigmanager.android.enums.PigBoyVarietyEnum;
import com.pigmanager.android.enums.PigGirlVarietyEnum;
import com.pigmanager.android.enums.PigTypeEnum;
import com.pigmanager.basiclib.utils.ToastUtils;

import java.io.Serializable;

/**
 * Created by wdw on 2018/6/15.
 */

public class AddSeedPigBean extends BaseReponseBean<AddSeedPigBean> implements Serializable {

    // 猪场编号
    public String F_MerchantCode;
    // 猪的类型:公猪或母猪...
    public String F_PigType;
    // 猪的品种
    public String F_PigVariety;
    // 耳标
    public String F_EarTag;
    //类别索引
    public transient int index_Category;
    // 猪的类别:母猪（后备，基础），公猪（后备）母猪生仔后，就从后备变成基础了
    public String F_PigCategory;
    // 公猪：采精次数
    public Integer F_SemanCount;
    // 母猪：后备 交配，孕检，分娩，断奶
    public Integer F_PigCurrentState;
    public String F_PigCurrentStateName;
    // 生育次数
    public Integer F_ChildCount;
    // 母猪：配种次数
    public Integer F_MatingCount;
    // 栋舍名称
    public String F_PigHouseName;
    // 栏位
    public String F_Field;
    // 出生日期
    public String F_PigBirthday;
    //记录的当前时间
    public transient long curTime;
    // 猪的来源
    public String F_PigOrigin;

    public ArrayMap<String, Object> ToMap() {
        ArrayMap<String, Object> data = new ArrayMap<>();
        data.put("F_PigType", this.F_PigType);
        data.put("F_PigVariety", this.F_PigVariety);
        data.put("F_EarTag", this.F_EarTag);
        data.put("F_PigCategory", this.F_PigCategory);
        data.put("F_ChildCount", this.F_ChildCount);
        data.put("F_PigHouseName", this.F_PigHouseName);
        data.put("F_Field", this.F_Field);
        data.put("F_PigBirthday", this.F_PigBirthday);
        data.put("F_PigOrigin", this.F_PigOrigin);
        data.put("F_SemanCount", this.F_SemanCount);
        return data;
    }

    //验证数据正确性
    public Boolean Valid() {
        //空值验证
        if (TextUtils.isEmpty(this.F_PigVariety) || TextUtils.isEmpty(this.F_EarTag)
                || TextUtils.isEmpty(this.F_ChildCount.toString())) {
            ToastUtils.showLongToast(R.string.action_cannot_empty);
            return false;
        }
        //胎龄验证
        if (this.F_ChildCount < 0 || this.F_ChildCount > 15) {
            ToastUtils.showLongToast(R.string.action_PigChildCountError);
            return false;
        }
        //猪的品种验证
        String key = "";
        if (this.F_PigType == PigTypeEnum.Boy_Pig.getKey()) {
            PigBoyVarietyEnum pigBoyVariety = PigBoyVarietyEnum.getEnum(this.F_PigVariety);
            key = pigBoyVariety.getKey();
        } else {
            PigGirlVarietyEnum pigGirlVariety = PigGirlVarietyEnum.getEnum(this.F_PigVariety);
            key = pigGirlVariety.getKey();
        }
        if (!this.F_EarTag.substring(0, key.length()).equals(key)) {
            ToastUtils.showLongToast(R.string.action_PigEarTagError);
            return false;
        }

        return true;
    }
}
