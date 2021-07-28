package com.example.demo3.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("account")
public class AccountController {
    @GetMapping("toLogin")
    public String toLogin(){
        return "Login";
    }
    @GetMapping("toMain")
    public String tomain(){return "main";}
    @GetMapping("toChuzhang")
    public String toChuzhang(){return "chuzhang";}
}
