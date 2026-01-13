package com.bill.service;

import com.bill.entity.user;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
    boolean checkUser(String username);
    String login(String username,String password);
    String register(String username,String password);
}
