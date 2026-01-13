package com.bill.tools;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;


public class securityTool {

    private securityTool() {
        throw new IllegalStateException("工具类不允许实例化");
    }

    //检测Session中是否包含用户属性
    public static boolean hasUserInSession(HttpSession session) {
        if (session == null) {
            return false;
        }
        Object user = session.getAttribute("user");
        return user != null;
    }
}