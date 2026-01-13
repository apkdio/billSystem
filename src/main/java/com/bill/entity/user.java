package com.bill.entity;

public class user {
    private int user_id;
    private String name;
    private String password;

    public user(int user_id, String name, String password) {
        this.user_id = user_id;
        this.name = name;
        this.password = password;
    }

    public user(String name, String password) {
        this.name = name;
        this.password = password;
    }

    public user() {
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "user_id=" + user_id +
                ", name='" + name +
                ", password='" + password;
    }
}
