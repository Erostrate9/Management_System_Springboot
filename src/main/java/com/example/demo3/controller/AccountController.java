package com.example.demo3.controller;

import com.example.demo3.entity.Account;
import com.example.demo3.entity.AccountType;
import com.example.demo3.entity.CityCode;
import com.example.demo3.entity.ProductCode;
import com.example.demo3.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("account")
public class AccountController {
    //调用service对象中的方法
    private AccountService asi;
    public AccountService getAsi() {
        return asi;
    }
    @Autowired
    public void setAsi(AccountService asi) {
        this.asi = asi;
    }

    @GetMapping("toLogin")
    public String toLogin(){
        return "Login";
    }

    @GetMapping("toMain")
    public String tomain(){return "main";}

    @GetMapping("toChuzhang")
    public String toChuzhang(Model model){
        //获取集合数据
        List<Account> list=asi.getAccount();
        List<CityCode> cityList=asi.getCityCode();
        List<ProductCode> productCodeList=asi.getProductCode();
        List<AccountType> accountTypeList=asi.getAccountType();
        model.addAttribute("accountList",list);
        model.addAttribute("cityList",cityList);
        model.addAttribute("productCodeList",productCodeList);
        model.addAttribute("accountTypeList",accountTypeList);
        return "chuzhang";
    }
}
