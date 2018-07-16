package com.pigmanager.android.bean;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by wdw on 2018/6/15.
 */

public class PigDieOutBean extends BaseReponseBean implements Serializable {
    //唯一标号
    public String F_Id;
    // 猪场编号
    public String F_MerchantCode;
    //猪编号
    public String F_PigRecordId;
    //死淘类型
    public String F_DieOutType;
    //死淘原因
    public String F_DieOutReason;
    //操作人
    public String F_OperatePerson;
    //操作时间
    public Date F_OperateTime;

}
