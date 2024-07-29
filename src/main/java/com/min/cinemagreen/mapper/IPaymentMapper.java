package com.min.cinemagreen.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IPaymentMapper {
  int insertPay(Map <String,Object> pay);

  
  //int deletePay(int payId);
}
