package com.bill.service;

import com.bill.entity.user;
import com.bill.mapper.userMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Service
public class UserServiceImpl {
    @Autowired
    private userMapper userMapper;

    public String login(String username, String password, RedirectAttributes redirectAttributes) {
        user user = userMapper.findByName(username);
        if (user == null) {
            return "用户名不存在！";
        } else {
            user userWithNamePass = userMapper.findByNameAndPassword(username, password);
            if (userWithNamePass == null) {
                return "用户名或密码错误！";
            } else {
                return "success";
            }
        }
    }

    public boolean checkUser(String username) {
        if (!StringUtils.hasText(username)) {
            return false;
        }
        user user = userMapper.findByName(username);
        return user != null;
    }

    public boolean register(user user) {
        return userMapper.insertUser(user);
    }
}
