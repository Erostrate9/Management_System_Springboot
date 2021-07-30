package com.example.demo3.service;

import com.example.demo3.dao.AccountDao;
import com.example.demo3.entity.Account;
import com.example.demo3.entity.AccountType;
import com.example.demo3.entity.CityCode;
import com.example.demo3.entity.ProductCode;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
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
    public List<Account> getAccount(Account account){
        return ada.getAccount(account);
    }
    public List<CityCode> getCityCode(){
        return ada.getCityCode();
    }
    public List<ProductCode> getProductCode(){return ada.getProductCode();}
    public List<AccountType> getAccountType(){return ada.getAccountType();}
    public int insertAccount(Account account){return ada.insertAccount(account);}
    public Account getAccountById(Integer id){return ada.getAccountById(id);}
    public int updateAccount(Account account){return ada.updateAccount(account);}
    public int deleteAccount(Integer id){return ada.deleteAccount(id);}
    public XSSFWorkbook getTemplate() {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet();
        XSSFRow row = sheet.createRow(0);
        row.createCell(0).setCellValue("录入月份");
        row.createCell(1).setCellValue("城市编码");
        row.createCell(2).setCellValue("产品编码");
        row.createCell(3).setCellValue("出账收入类型编码");
        row.createCell(4).setCellValue("录入金额");
        return workbook;
    }
    /**
     *   解析Excel
     * @param file
     * @return
     */
    @SuppressWarnings("resource")
    public List<Account> parseExcel(File file) {

        FileInputStream fis = null;
        try {
            fis = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            return null;
        }
        XSSFWorkbook workbook = null;
        try {
            workbook = new XSSFWorkbook(fis);
        } catch (IOException e) {
            return null;
        }
        XSSFSheet sheet = workbook.getSheetAt(0);
        List<Account> list = new ArrayList<Account>();
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            XSSFRow row = sheet.getRow(i);
            Account si = new Account();
            for (int j = 0; j < row.getLastCellNum(); j++) {
                XSSFCell cell = row.getCell(j);
                switch(j) {
                    case 0:
                        Double month = cell.getNumericCellValue();
                        double dmonth=month.doubleValue();
                        int idmonth=(int)dmonth;
                        String sidmonth=idmonth+"";

                        si.setMonth(sidmonth);
                        break;
                    case 1:
                        Double cityCode = cell.getNumericCellValue();
                        double dcityCode=cityCode.doubleValue();
                        int icityCode=(int)dcityCode;
                        String scityCode=icityCode+"";
                        si.setCityCode(scityCode);
                        break;
                    case 2:
                        Double productCode = cell.getNumericCellValue();
                        double dproductCode=productCode.doubleValue();
                        int iproductCode=(int)dproductCode;
                        String sproductCode=iproductCode+"";
                        si.setProductCode(sproductCode);
                        break;
                    case 3:
                        Double accoundTypeCode = cell.getNumericCellValue();
                        double daccoundTypeCode=accoundTypeCode.doubleValue();
                        int iaccoundTypeCode=(int)daccoundTypeCode;
                        String saccoundTypeCode=iaccoundTypeCode+"";
                        si.setTypeCode(saccoundTypeCode);
                        break;
                    case 4:
                        Double AccounFee = cell.getNumericCellValue();
                        System.out.println(AccounFee);
                        si.setFee(AccounFee);
                        break;
                    default : return null;
                }
            }
            list.add(si);
        }
        return list;
    }
    public int batchInsert(List<Account> list){
        int successfulInsertNum=0;
        for (Account account:list) {
            successfulInsertNum+=ada.insertAccount(account);
        }
        return successfulInsertNum;
    }
}
