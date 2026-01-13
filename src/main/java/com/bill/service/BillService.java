package com.bill.service;

import com.bill.entity.bill;

import java.util.List;

public interface BillService {
    String makeBill(String username, double money, String comment, String date, String type);

    int billNumber(String username);

    List<bill> allBill(String username, int start, int end);

    bill findBillById(int id);

    boolean updateBill(int id, double money, String comment, String date, String type);
    boolean deleteBill(int id);
    double findAllMoney(String name, String type);
}
