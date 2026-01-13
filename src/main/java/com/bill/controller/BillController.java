package com.bill.controller;

import com.bill.entity.bill;
import com.bill.service.BillServiceImpl;
import com.bill.tools.securityTool;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BillController {
    @Autowired
    private BillServiceImpl billService;
    
    @PostMapping("/makeBill")
    @ResponseBody
    public String makeBill(@RequestParam int type, @RequestParam double money, @RequestParam String date,
                           @RequestParam String comment, HttpSession session) {
        if (securityTool.hasUserInSession(session)) {
            String username = (String) session.getAttribute("user");
            String bill_type;
            if (type == 0) {
                bill_type = "收入";
            } else if (type == 1) {
                bill_type = "支出";
            } else {
                return "fail";
            }
            return billService.makeBill(username, money, date, comment, bill_type);
        } else {
            return "fail";
        }
    }

    @GetMapping("/bill")
    public String bill(HttpSession session,
                       @RequestParam(name = "page", defaultValue = "1") int page, Model model) {
        if (securityTool.hasUserInSession(session)) {
                String username = (String) session.getAttribute("user");
                int end = 10;
                int start = (page - 1) * end;
                List<bill> data = billService.allBill(username, start, end);
                int total = billService.billNumber(username);
                double income = billService.findAllMoney(username, "收入");
                double outcome = billService.findAllMoney(username, "支出");
                if (start > total) {
                    return "redirect:/bill?page=1";
                }
                model.addAttribute("data", data);
                model.addAttribute("currentPage", page);
                model.addAttribute("totalBill", total);
                model.addAttribute("income", income);
                model.addAttribute("outcome", outcome);
                return "bill";

        } else {
            return "login";
        }
}

@GetMapping("/billEdit")
@ResponseBody
public Map<String, bill> billEdit(HttpSession session, @RequestParam(name = "bid") int bid) {
    Map<String, bill> result = new HashMap<>();
    if (securityTool.hasUserInSession(session)) {
        bill info = billService.findBillById(bid);
        result.put("success", info);
        return result;
    } else {
        result.put("fail", null);
        return result;
    }
}

@PostMapping("/billEdit")
@ResponseBody
public String billEdit(@RequestParam int bid, @RequestParam String date,
                       @RequestParam String comment,
                       @RequestParam double money, @RequestParam String type, HttpSession session) {
    if (securityTool.hasUserInSession(session)) {
        if (billService.updateBill(bid, money, comment, date, type)) {
            return "success";
        } else {
            return "fail";
        }
    } else {
        return "fail";
    }
}

@GetMapping("billDelete")
@ResponseBody
public String billDelete(@RequestParam int bid, HttpSession session) {
    if (securityTool.hasUserInSession(session)) {
        if (billService.deleteBill(bid)) {
            return "success";
        } else {
            return "fail";
        }
    } else {
        return "fail";
    }
}
}