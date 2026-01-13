package com.bill.service;

import com.bill.entity.bill;
import com.bill.mapper.billMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillServiceImpl implements BillService {
    @Autowired
    private billMapper billMapper;

    @Override
    public String makeBill(String username, double money, String date, String comment, String type) {
        boolean result = billMapper.makeBill(username, money, date, comment, type);
        if (result) {
            return "success";
        } else {
            return "fail";
        }
    }

    @Override
    public int billNumber(String username) {
        return billMapper.billNumber(username);
    }

    @Override
    public List<bill> allBill(String username, int start, int end) {
        return billMapper.allBill(username, start, end);
    }

    @Override
    public bill findBillById(int id) {
        return billMapper.selectBillById(id);
    }

    @Override
    public boolean updateBill(int id, double money, String comment, String date, String type) {
        return billMapper.updateBillById(id, money, comment, date, type);
    }
    public boolean deleteBill(int id) {
        return billMapper.deleteBillById(id);
    }

    @Override
    public double findAllMoney(String name, String type) {
        return billMapper.findAllMoney(name,type);
    }
}
