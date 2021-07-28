package com.example.demo3.dao;

import com.example.demo3.entity.Account;

import java.util.List;

public interface AccountDao {
    //查询Account表中所有的数据，把每一行数据封装成一个Account对象
    // 多个对象放到集合中，把它返回
    public List<Account> getAccount();
}
