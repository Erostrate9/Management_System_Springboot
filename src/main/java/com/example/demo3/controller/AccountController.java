package com.example.demo3.controller;

import com.example.demo3.entity.Account;
import com.example.demo3.entity.AccountType;
import com.example.demo3.entity.CityCode;
import com.example.demo3.entity.ProductCode;
import com.example.demo3.service.AccountService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
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

    /**
     *
     * @param model 携带数据返回
     * @param pageSize 一页显示多少条-非必传值
     * @param pageNum 显示当前页--必传值
     * @return 前端页面
     * @Author: eros9
     * @Date: 2021/8/1
     */
//分页查询数据
    @GetMapping("toChuzhang")
    public String toChuzhang(Model model,Account account,@RequestParam(required = false,defaultValue="1",value="pageNum")Integer pageNum,
                             @RequestParam(defaultValue="5",value="pageSize")Integer pageSize){
        //获取集合数据
        List<CityCode> cityList=asi.getCityCode();
        List<ProductCode> productCodeList=asi.getProductCode();
        List<AccountType> accountTypeList=asi.getAccountType();
        model.addAttribute("cityList",cityList);
        model.addAttribute("productCodeList",productCodeList);
        model.addAttribute("accountTypeList",accountTypeList);
        //往model中传入一个空的Account对象
        model.addAttribute("account",account==null?new Account():account);
        //为了程序的严谨性，判断非空：
        if(pageNum == null){
            pageNum = 1;   //设置默认当前页
        }
        if(pageNum <= 0){
            pageNum = 1;
        }
        if(pageSize == null){
            pageSize = 5;    //设置默认每页显示的数据数
        }
        System.out.println("当前页是："+pageNum+"显示条数是："+pageSize);

        //1.引入分页插件,pageNum是第几页，pageSize是每页显示多少条,默认查询总数count
        PageHelper.startPage(pageNum,pageSize);
        //2.紧跟的查询就是一个分页查询-必须紧跟.后面的其他查询不会被分页，除非再次调用PageHelper.startPage
        try {
            List<Account> list=asi.getAccount(account);
            model.addAttribute("accountList",list);
            System.out.println("分页数据："+list);
            //3.使用PageInfo包装查询后的结果,5是连续显示的条数,结果list类型是Page<E>
            PageInfo<Account> pageInfo = new PageInfo<Account>(list,pageSize);
            //4.使用model/map/modelandview等带回前端
            model.addAttribute("pageInfo",pageInfo);
        }finally {
            PageHelper.clearPage(); //清理 ThreadLocal 存储的分页参数,保证线程安全
        }

        return "chuzhang";
    }

    @PostMapping("toChuzhang")
    public String queryChuzhang(Model model,Account account,@RequestParam(required = false,defaultValue="1",value="pageNum")Integer pageNum,
                                @RequestParam(defaultValue="5",value="pageSize")Integer pageSize){
        //获取集合数据
        List<CityCode> cityList=asi.getCityCode();
        List<ProductCode> productCodeList=asi.getProductCode();
        List<AccountType> accountTypeList=asi.getAccountType();
        model.addAttribute("cityList",cityList);
        model.addAttribute("productCodeList",productCodeList);
        model.addAttribute("accountTypeList",accountTypeList);
        //为了程序的严谨性，判断非空：
        if(pageNum == null){
            pageNum = 1;   //设置默认当前页
        }
        if(pageNum <= 0){
            pageNum = 1;
        }
        if(pageSize == null){
            pageSize = 5;    //设置默认每页显示的数据数
        }
        System.out.println("当前页是："+pageNum+"显示条数是："+pageSize);

        //1.引入分页插件,pageNum是第几页，pageSize是每页显示多少条,默认查询总数count
        PageHelper.startPage(pageNum,pageSize);
        //2.紧跟的查询就是一个分页查询-必须紧跟.后面的其他查询不会被分页，除非再次调用PageHelper.startPage
        try {
            List<Account> list=asi.getAccount(account);
            model.addAttribute("accountList",list);
            System.out.println("分页数据："+list);
            //3.使用PageInfo包装查询后的结果,5是连续显示的条数,结果list类型是Page<E>
            PageInfo<Account> pageInfo = new PageInfo<Account>(list,pageSize);
            //4.使用model/map/modelandview等带回前端
            model.addAttribute("pageInfo",pageInfo);
        }finally {
            PageHelper.clearPage(); //清理 ThreadLocal 存储的分页参数,保证线程安全
        }
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
    //    上传模板
    @GetMapping("import1")
    public String import1(){
        return "ChuzhangImport";
    }
    /**
     * 导入文件
     * @author wys
     * @param file
     * @return
     */
    @PostMapping("/upload")
    public String uploadFile(@RequestParam("uploadFile") MultipartFile file, Model model, HttpServletResponse response) {
        if (file == null || file.getSize() == 0) {
            model.addAttribute("error_msg", "文件不能为空");
            return "viewTemplates/error";//pass
        }

        //获取文件名称
        String fileName = file.getOriginalFilename();

        //判断文件类型
        String[] str = fileName.split("\\.");
        if (str.length != 2 || !str[1].equals("xlsx")) {
            model.addAttribute("error_msg", "文件格式不正确");
            return "viewTemplates/error";
        }
        //转换成本地文件
        File excel = null;
        try {
            excel = File.createTempFile(str[0], str[1]);
            file.transferTo(excel);
        } catch (IOException e) {
            model.addAttribute("error_msg", "转换文件发生错误！");
            return "viewTemplates/error";
        }
        try {
            List<Account> list = asi.parseExcel(excel);
            System.out.println(list.size());
            System.out.println(list.get(0).getCityCode());
            if (list == null || list.size() == 0) {
                model.addAttribute("error_msg", "文件内容为空！");
                return "viewTemplates/error";
            }
            asi.batchInsert(list);
        } catch (Exception e) {
            model.addAttribute("error_msg", "导入文件发生错误！");
            return "viewTemplates/error";
        }
        //重定向
        return "redirect:/account/toChuzhang";
    }
    @ResponseBody
    @PostMapping("deleteBatch")
    public String deleteBatch(@RequestParam("ids[]")Integer[]ids){
        int res=0;
        for (Integer id:ids) {
            res+=asi.deleteAccount(id);
        }
        if (res>0){
            return "success";
        }else{
            return "failed";
        }

    }



}
