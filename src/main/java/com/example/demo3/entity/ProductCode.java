package com.example.demo3.entity;

import java.util.Objects;

public class ProductCode {
    private String productCode;
    private String productName;
    private String useFlag;
    private String useAccount;
    private String useCardSale;
    private String useBalance;
    private String usePreFee;
    private String useBusinessFee;

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getUseFlag() {
        return useFlag;
    }

    public void setUseFlag(String useFlag) {
        this.useFlag = useFlag;
    }

    public String getUseAccount() {
        return useAccount;
    }

    public void setUseAccount(String useAccount) {
        this.useAccount = useAccount;
    }

    public String getUseCardSale() {
        return useCardSale;
    }

    public void setUseCardSale(String useCardSale) {
        this.useCardSale = useCardSale;
    }

    public String getUseBalance() {
        return useBalance;
    }

    public void setUseBalance(String useBalance) {
        this.useBalance = useBalance;
    }

    public String getUsePreFee() {
        return usePreFee;
    }

    public void setUsePreFee(String usePreFee) {
        this.usePreFee = usePreFee;
    }

    public String getUseBusinessFee() {
        return useBusinessFee;
    }

    public void setUseBusinessFee(String useBusinessFee) {
        this.useBusinessFee = useBusinessFee;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductCode that = (ProductCode) o;
        return Objects.equals(productCode, that.productCode) && Objects.equals(productName, that.productName) && Objects.equals(useFlag, that.useFlag) && Objects.equals(useAccount, that.useAccount) && Objects.equals(useCardSale, that.useCardSale) && Objects.equals(useBalance, that.useBalance) && Objects.equals(usePreFee, that.usePreFee) && Objects.equals(useBusinessFee, that.useBusinessFee);
    }

    @Override
    public int hashCode() {
        return Objects.hash(productCode, productName, useFlag, useAccount, useCardSale, useBalance, usePreFee, useBusinessFee);
    }
}
