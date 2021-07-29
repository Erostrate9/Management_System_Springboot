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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
    public String toChuzhang(Model model,Account account){
        //获取集合数据
        List<Account> list=asi.getAccount(account);
        List<CityCode> cityList=asi.getCityCode();
        List<ProductCode> productCodeList=asi.getProductCode();
        List<AccountType> accountTypeList=asi.getAccountType();
        model.addAttribute("accountList",list);
        model.addAttribute("cityList",cityList);
        model.addAttribute("productCodeList",productCodeList);
        model.addAttribute("accountTypeList",accountTypeList);
        //往model中传入一个空的Account对象
        model.addAttribute("account",account==null?new Account():account);
        return "chuzhang";
    }

    @PostMapping("toChuzhang")
    public String queryChuzhang(Model model,Account account){
        //获取集合数据
        List<Account> list=asi.getAccount(account);
        List<CityCode> cityList=asi.getCityCode();
        List<ProductCode> productCodeList=asi.getProductCode();
        List<AccountType> accountTypeList=asi.getAccountType();
        model.addAttribute("accountList",list);
        model.addAttribute("cityList",cityList);
        model.addAttribute("productCodeList",productCodeList);
        model.addAttribute("accountTypeList",accountTypeList);
        return "chuzhang";
    }

    @GetMapping("toChuzhangAdd")
    public String toChuzhangAdd(Model model,Account account){
        //带一个空Account对象走
        model.addAttribute("account",account==null?new Account():account);

        return "ChuzhangAdd";
    }
    @PostMapping("toChuzhangAdd")
    public void toChuzhangAdd1(Model model, Account account, HttpServletResponse response){
        int finishedInsertNum = asi.insertAccount(account);
        System.out.println(finishedInsertNum);
        //当插入成功后，跳转到本controller的获取Account的方法中
        //重定向
        try {
            response.sendRedirect("/account/toChuzhang");
        }catch (IOException e) {
            e.printStackTrace();
            System.out.println("重定向失败");
        }
    }
}
