package com.example.demo3.controller;

import com.example.demo3.entity.Account;
import com.example.demo3.entity.AccountType;
import com.example.demo3.entity.CityCode;
import com.example.demo3.entity.ProductCode;
import com.example.demo3.service.AccountService;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
    public String toChuzhangAdd(Integer id, Model model, Account account){
        if (id==null||"".equals(id)){
            //添加
            //带一个空Account对象走
            model.addAttribute("account",account==null?new Account():account);
        }else{
            //修改
            model.addAttribute("account",asi.getAccountById(id));
        }
        //获取集合数据
        List<CityCode> cityList=asi.getCityCode();
        List<ProductCode> productCodeList=asi.getProductCode();
        List<AccountType> accountTypeList=asi.getAccountType();
        model.addAttribute("cityList",cityList);
        model.addAttribute("productCodeList",productCodeList);
        model.addAttribute("accountTypeList",accountTypeList);
        return "ChuzhangAdd";
    }
    @PostMapping("toChuzhangAdd")
    public void toChuzhangAdd1(Model model, Account account, HttpServletResponse response){
        System.out.println("account.id:"+account.getId());
        if (account.getId()==null|| "".equals(account.getId())){
            //添加
            int finishedInsertNum = asi.insertAccount(account);
            System.out.println("Insert:"+finishedInsertNum);
        }else{
            int finishedInsertNum = asi.updateAccount(account);
            System.out.println("update:"+finishedInsertNum);
        }
        //当插入或修改成功后，跳转到本controller的获取Account的方法中
        //重定向
        try {
            response.sendRedirect("/account/toChuzhang");
        }catch (IOException e) {
            e.printStackTrace();
            System.out.println("重定向失败");
        }
    }
    //删除
    @GetMapping("toChuzhangDelete")
    public void toChuzhangDelete(Integer id,HttpServletResponse response){
        System.out.println("account.id:"+id);
        if (id==null){
            System.out.println("id doesn't exist");
        }else{
            int finishedDelNum = asi.deleteAccount(id);
            System.out.println("Delete:"+finishedDelNum);
        }
//        当删除成功后，跳转到本controller的获取Account的方法中
        //重定向
        try {
            response.sendRedirect("/account/toChuzhang");
        }catch (IOException e) {
            e.printStackTrace();
            System.out.println("重定向失败");
        }
    }
    @GetMapping("toChuzhangUpdate")
    public String toChuzhangUpdate(Integer id, Model model, Account account,HttpServletResponse response){
        if (id==null||"".equals(id)){
            //重定向
            try {
                response.sendRedirect("/account/toChuzhang");
            }catch (IOException e) {
                e.printStackTrace();
                System.out.println("重定向失败");
            }
        }else{
            //修改
            model.addAttribute("account",asi.getAccountById(id));
        }
        //获取集合数据
        List<CityCode> cityList=asi.getCityCode();
        List<ProductCode> productCodeList=asi.getProductCode();
        List<AccountType> accountTypeList=asi.getAccountType();
        model.addAttribute("cityList",cityList);
        model.addAttribute("productCodeList",productCodeList);
        model.addAttribute("accountTypeList",accountTypeList);
        return "ChuzhangUpdate";
    }
    @PostMapping("toChuzhangUpdate")
    public void toChuzhangUpdate1(Model model, Account account, HttpServletResponse response){
        System.out.println("account.id:"+account.getId());
        if (account.getId()==null|| "".equals(account.getId())){
            //添加
            int finishedInsertNum = asi.insertAccount(account);
            System.out.println("Insert:"+finishedInsertNum);
        }else{
            int finishedInsertNum = asi.updateAccount(account);
            System.out.println("update:"+finishedInsertNum);
        }
        //当插入或修改成功后，跳转到本controller的获取Account的方法中
        //重定向
        try {
            response.sendRedirect("/account/toChuzhang");
        }catch (IOException e) {
            e.printStackTrace();
            System.out.println("重定向失败");
        }
    }

    /**
     *  下载模板
     * @return
     */
    @GetMapping("/download")
    public void downloadTemplate(HttpServletResponse response) {
        XSSFWorkbook workbook = asi.getTemplate();
        //设置下载时的响应头
        try {
            response.setHeader("content-disposition","attachment;fileName="+ URLEncoder.encode("导入模板","UTF-8")+".xlsx");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        //通过响应流响应即可
        ServletOutputStream outputStream;
        try {
            outputStream = response.getOutputStream();
            workbook.write(outputStream);
        } catch (IOException e1) {
            e1.printStackTrace();
        }
    }

}
