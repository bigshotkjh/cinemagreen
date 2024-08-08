package com.min.cinemagreen.payment.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.OccupiedSeatDTO;
import com.min.cinemagreen.dto.PaymentDTO;

@Mapper
public interface IPaymentMapper {
  
  int payInsert(Map<String, Object> pay);
  PaymentDTO getPayInfo(String payId);
  int insertTicket(Map<String, Object> pay);
  int insertOccpSeat(Map<String, Object> pay);
  List<OccupiedSeatDTO> getSeatByTicketNo(String ticketingNo);
  List<String> getOccpSeats();
  List<String> getOccpSeatsInfo(String ticketingNo);
}
