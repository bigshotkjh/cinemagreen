package com.min.cinemagreen.payment.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.min.cinemagreen.dto.PaymentDTO;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

public interface IPaymentService {

  int payInsert(Map <String,Object> pay);
  IamportResponse<Payment> getPaymentInfo(String imp_uid, String token) throws IamportResponseException, IOException;
  Map<String, Object> getPayInfo(String payId);
  String getToken(String apiKey, String secretKey) throws IOException;
  int ticketing(Map<String, Object> pay);
  void saveOccpSeat(Map<String, Object> pay);
  List<String> getOccpSeats();

}

