package com.example.demo3.dao;

import com.example.demo3.entity.Account;
import com.example.demo3.entity.CityCode;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
//利用上面两个注解实例化对象
public interface AccountDao {
    //查询Account表中所有的数据，把每一行数据封装成一个Account对象
    // 多个对象放到集合中，把它返回
    public List<Account> getAccount();
    public List<CityCode> getCityCode();
}
