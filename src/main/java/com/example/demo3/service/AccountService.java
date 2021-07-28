package com.example.demo3.service;

import com.example.demo3.dao.AccountDao;
import com.example.demo3.entity.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

//业务逻辑层

@Service
public class AccountService {
    //调用数据访问层  拿到数据访问层的对象
    //通过 对象.方法 进行调用
    private AccountDao ada;

    public AccountDao getAda() {
        return ada;
    }
//    把内存中AccountDao对象复制给ada
    @Autowired
    public void setAda(AccountDao ada) {
        this.ada = ada;
    }
    public List<Account> getAccount(){
        return ada.getAccount();
    }
}
