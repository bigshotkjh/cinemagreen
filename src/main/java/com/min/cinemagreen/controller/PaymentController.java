package com.min.cinemagreen.controller;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.min.cinemagreen.dto.PaymentDTO;
import com.min.cinemagreen.dto.UserDTO;
import com.min.cinemagreen.service.IPaymentService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/payment")
@RequiredArgsConstructor
@Controller
public class PaymentController {

  private final IPaymentService paymentService;
	//private final IamportClient iamportClient;

	  @Value("${imp.api.key}")
    private String apiKey;
	 
    @Value("${imp.api.secretkey}")
    private String secretKey;
    
    IamportClient iamportClient = new IamportClient("6848584747520311", "NvwsO9QDV9fzxqFpF5KmqoPpz1O9lUOM5MIKou6kKikg46ivyWoK6y7oAMGX83xf1KdOCrJxQufBsPbu");



    //결제내역 반환  
    @ResponseBody
    @PostMapping("validation/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(@PathVariable(value = "imp_uid") String imp_uid, HttpServletRequest request) throws IamportResponseException, IOException {
      IamportResponse<Payment> payinfo = iamportClient.paymentByImpUid(imp_uid);
      log.info("imp_uid: {}", imp_uid);
      log.info("validateIamport");
      
      return payinfo;
    }
    
    
    @ResponseBody
    @PostMapping("completeInsert")
    public int savePaymentInfo( @RequestBody Map<String,Object> pay, HttpSession session,Model model) throws IOException {
    // String token = paymentService.getToken();
      log.info("map : {}" ,pay);
      UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
      pay.put("userNo", loginUser.getUserNo());
      int result = paymentService.payInsert(pay);
      return result;
    }
      
      
    
    @GetMapping(value = "complete/{payId}")
    public String getPaymentInfo(@PathVariable String payId, Model model) {
      PaymentDTO payment = paymentService.getPayInfo(payId);
      model.addAttribute("payment", payment);
      return "/payment/complete";
    }
    
    /* 
    // complete 임시 ..
    @GetMapping("complete")
    public String getPaymentInfo( @RequestParam String payId, Model model) throws IOException {
      //List<PaymentDTO> payList = paymentService.paySelect(payId); 
      PaymentDTO payment = (PaymentDTO) paymentService.paySelect(payId); 

      model.addAttribute("payment", payment);
      
      return "/reserve/complete";
    }
    */

   
 // 결제 취소
    @PostMapping("paymentCancel")
    public void cancelPayment(String imp_uid) throws IamportResponseException, IOException {
    // String token = paymentService.getToken(String apiKey, String secretKey));
     //cancelData 생성
     CancelData cancelData = new CancelData(imp_uid, true);
     //결제 취소
     iamportClient.cancelPaymentByImpUid(cancelData);
    }
    
    
    
    
}