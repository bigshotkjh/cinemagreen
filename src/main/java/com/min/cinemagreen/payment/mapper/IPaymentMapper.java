package com.min.cinemagreen.payment.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.PaymentDTO;

@Mapper
public interface IPaymentMapper {
  
  int payInsert(Map<String, Object> pay);

  PaymentDTO getPayInfo(String payId);
  
}
