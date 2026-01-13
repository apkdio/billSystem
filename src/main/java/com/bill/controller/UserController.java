package com.bill.controller;
import com.bill.entity.user;
import com.bill.service.UserServiceImpl;
import com.bill.tools.securityTool;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/")
public class UserController {
    @Autowired
    private UserServiceImpl userService;

    @PostMapping("/login")
    public String login(@RequestParam("username") String username,
                        @RequestParam("password") String password,
                        HttpSession session, RedirectAttributes redirectAttributes) {
        if (!StringUtils.hasText(username) || !StringUtils.hasText(password)) {
            redirectAttributes.addFlashAttribute("error", "用户名或密码不能为空");
            return "redirect:/login";
        } else {
            String loginResult = userService.login(username, password, redirectAttributes);
            if (!Objects.equals(loginResult, "success")) {
                redirectAttributes.addFlashAttribute("error", loginResult);
                return "redirect:/login";
            } else {
                session.setAttribute("user", username);
                return "redirect:/information";
            }
        }
    }


    @PostMapping("/register")
    @ResponseBody
    public Map<String, String> register(@RequestParam String username, @RequestParam String password) {
        Map<String, String> result = new HashMap<>();
        if (!StringUtils.hasText(username) || !StringUtils.hasText(password)) {
            result.put("error", "用户名为空！");
            return result;
        } else {
            boolean userExist = userService.checkUser(username);
            if (userExist) {
                result.put("error", "用户名已存在！");
                return result;
            } else {
                user user = new user(username, password);
                boolean findResult = userService.register(user);
                if (findResult) {
                    result.put("success", "注册成功！");
                    return result;
                } else {
                    result.put("error", "未注册成功，请重试！");
                    return result;
                }
            }
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        boolean isLogin = securityTool.hasUserInSession(session);
        if (isLogin) {
            return "redirect:/information";
        }
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(HttpSession  session) {
        boolean isLogin = securityTool.hasUserInSession(session);
        if (isLogin) {
            return "redirect:/information";
        }
        return "register";
    }

    @GetMapping("/information")
    public String informationPage(HttpSession session) {
        boolean isLogin = securityTool.hasUserInSession(session);
        if (!isLogin) {
            return "redirect:/login";
        }
        return "information";
    }
}