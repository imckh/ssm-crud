package com.ckh.ssm.model;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

/**
 * 2018/1/26 14:38
 *
 * @author CKH
 *
 * 返回json的通用类
 */
public class Msg {
    //状态码
    private int code;
    // 提示信息
    private String msg;

    // 用户要返回给浏览器的数据
    private Map<String, Object> extend = new HashMap<>();

    public static Msg success() {
        Msg result = new Msg();
        result.setMsg("处理成功");
        result.setCode(200);
        return result;
    }

    public static Msg fail() {
        Msg result = new Msg();
        result.setMsg("处理失败");
        result.setCode(400);
        return result;
    }

    public Msg add(String k, PageInfo v) {
        this.getExtend().put(k, v);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }


}
