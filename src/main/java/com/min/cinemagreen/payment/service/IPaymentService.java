package com.min.cinemagreen.payment.service;

import java.io.IOException;
import java.util.Map;

import com.min.cinemagreen.dto.OccupiedSeatDTO;
import com.min.cinemagreen.dto.PaymentDTO;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

public interface IPaymentService {

  //IamportResponse<Payment> getPaymentInfo(String imp_uid, String paid_amount) throws IamportResponseException, IOException ;
  //int payInsert(String imp_uid);
  int payInsert(Map <String,Object> pay);
  IamportResponse<Payment> getPaymentInfo(String imp_uid, String token) throws IamportResponseException, IOException;
  PaymentDTO getPayInfo(String payId);
  String getToken(String apiKey, String secretKey) throws IOException;
  //int ticketing(Map<String, Object> pay);
  int ticketing(Map<String, Object> pay);
  void saveOccpSeat(Map<String, Object> pay);
  OccupiedSeatDTO getSeatInfo(String ticketingNo);
 



}

