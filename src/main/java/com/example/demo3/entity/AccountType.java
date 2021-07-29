package com.example.demo3.entity;

import java.util.Objects;

public class AccountType {
    private String accountTypeCode;
    private String accountTypeName;

    public String getAccountTypeCode() {
        return accountTypeCode;
    }

    public void setAccountTypeCode(String accountTypeCode) {
        this.accountTypeCode = accountTypeCode;
    }

    public String getAccountTypeName() {
        return accountTypeName;
    }

    public void setAccountTypeName(String accountTypeName) {
        this.accountTypeName = accountTypeName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AccountType that = (AccountType) o;
        return Objects.equals(accountTypeCode, that.accountTypeCode) && Objects.equals(accountTypeName, that.accountTypeName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(accountTypeCode, accountTypeName);
    }
}
