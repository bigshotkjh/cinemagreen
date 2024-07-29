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
    
    
    IamportClient iamportClient = new IamportClient(apiKey, secretKey);


//    public PaymentController(IPaymentService paymentService) {
//        this.iamportClient = new IamportClient("6848584747520311", "NvwsO9QDV9fzxqFpF5KmqoPpz1O9lUOM5MIKou6kKikg46ivyWoK6y7oAMGX83xf1KdOCrJxQufBsPbu");
//        this.paymentService = paymentService;
//        
//    }


    //결제내역 반환     
    @ResponseBody
    @PostMapping("validation/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(@PathVariable(value = "imp_uid") String imp_uid, HttpServletRequest request) throws IamportResponseException, IOException {
      IamportResponse<Payment> payinfo = iamportClient.paymentByImpUid(imp_uid);
      log.info("imp_uid: {}", imp_uid);
      log.info("validateIamport");
      
      return payinfo;
    }
    
//    //결제 완료 임시...
//    @GetMapping(value = "complete.do")
//    public String reserveDo() {
//      return "/reserve/complete";
//    }
    
   
    @PostMapping("complete")
    public String getPaymentInfo( @RequestBody Map<String,Object> pay, HttpServletRequest request, HttpSession session,Model model) throws IOException {
    // String token = paymentService.getToken();
     log.info("map : {}" ,pay);
     paymentService.payInsert(pay);
     
//     UserDTO userDTO = (UserDTO) session.getAttribute("loginUser");
//     int userNo = null;
//     if(userDTO != null) {
//       userNo = userDTO.getUserNo();
//     }
//     pay.put("userNo", userNo);

      model.addAttribute("pay", pay);
      
      return "/reserve/complete";
    }
    

//    @ResponseBody
//    @GetMapping("complete")
//    public String getPaymentInfo(@RequestParam String imp_uid, HttpServletRequest request, Model model) throws IOException {
//      //PaymentDTO payment = paymentService.getPayinfo(imp_uid);
//      String token = paymentService.getToken();
//      System.out.println("token : " + token);
//     // PaymentDTO payment = new PaymentDTO();
//     // paymentService.payInsert(payment);
//      model.addAttribute("payId" , imp_uid);
//      return "/reserve/complete";
//      
//    }
    
    
   
//    public IamportResponse<Payment> paymentByImpUid(@RequestBody Map<String, Object> params) throws IamportResponseException, IOException{
//      log.info("controller: " + params.get("imp_uid").toString());
//      IamportResponse<Payment> payment = iamportClient.paymentByImpUid(params.get("imp_uid").toString());
//      // 데이터와 금액이 일치 확인 후 결제 성공 실패 여부 반환
//      log.info("결제 요청 응답. 결제 내역 - 주문 번호: {}", payment.getResponse().getMerchantUid());
//      return payment;
//    }
    
   
 // 결제 취소
    public void cancelPayment(String imp_uid) throws IamportResponseException, IOException {
      
     CancelData cancelData = new CancelData(imp_uid,true);
     iamportClient.cancelPaymentByImpUid(cancelData);
    }
}