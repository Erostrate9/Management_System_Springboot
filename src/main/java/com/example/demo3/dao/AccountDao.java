package com.example.demo3.dao;

import com.example.demo3.entity.Account;
import com.example.demo3.entity.AccountType;
import com.example.demo3.entity.CityCode;
import com.example.demo3.entity.ProductCode;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
//利用上面两个注解实例化对象
public interface AccountDao {
    //查询Account表中所有的数据，把每一行数据封装成一个Account对象
    // 多个对象放到集合中，把它返回
    public List<Account> getAccount(Account account);
    public List<CityCode> getCityCode();
    public List<ProductCode> getProductCode();
    public List<AccountType> getAccountType();

    //插入
    public int insertAccount(Account account);
    //根据id查询一个Account
    public Account getAccountById(Integer id);
    public int updateAccount(Account account);
    @Delete("DELETE FROM `rp_account_gather_t` WHERE `id` = #{id}")
    public int deleteAccount(Integer id);
}

