package com.scorpion.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.scorpion.domain.Criteria;
import com.scorpion.domain.LeaderVO;
import com.scorpion.domain.LevelTestVO;
import com.scorpion.domain.PageDTO;
import com.scorpion.domain.PaymentVO;
import com.scorpion.service.LeaderService;
import com.scorpion.service.PaymentService;
import com.scorpion.service.RefundService;
import com.scorpion.service.StudyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/pay/*")
@AllArgsConstructor
public class PayController {
   
	private PaymentService service;
	private StudyService studyservice;
	private LeaderService leaderservice;
	private RefundService refservice;
	
   @PreAuthorize("hasRole([ROLE_LEADER])")
   @GetMapping("/incomeList")
   public void get(Model model, Criteria cri,
		   @RequestParam("leaderId") String leaderId) {
	   model.addAttribute("leaderId", leaderId);
	   model.addAttribute("list", service.getIncomeList(cri, leaderId));
	   model.addAttribute("pageMaker", new PageDTO(cri,service.getTotalJoin(cri, leaderId)));
   }
   
   @PreAuthorize("hasRole([ROLE_STUDENT])")
   @GetMapping("/refund")
   public void refund(@RequestParam("payIndex") String payIndex, 
		   @RequestParam("studyIndex") Long studyIndex, Model model) {
	   model.addAttribute("study", studyservice.get(studyIndex));
	   model.addAttribute("payIndex", payIndex);
   }
   
   @PreAuthorize("hasRole([ROLE_STUDENT])")
   @PostMapping("/refund")
   public String refund(@RequestParam("payIndex") String payIndex, 
		   @RequestParam("studentId") String studentId, 
		   RedirectAttributes rttr) {
	   
	   refservice.register(Long.parseLong(payIndex));
	   rttr.addFlashAttribute("result", "success");
	   return "redirect:/pay/myMoneyList?studentId=" + studentId;
   }
   
   @PreAuthorize("hasRole([ROLE_ADMIN])")
   @GetMapping("/refundList")
   public void refundList(Model model, Criteria cri) {
	   model.addAttribute("list", refservice.getList(cri));
	   model.addAttribute("pageMaker", new PageDTO(cri, refservice.getTotal(cri)));
   }
   
   @PreAuthorize("hasRole([ROLE_ADMIN])")
   @PostMapping("/refundAccept")
   public String refundAccept(@RequestParam("refIndex") Long refIndex, 
		   @RequestParam("payIndex") Long payIndex, 
		   Criteria cri, RedirectAttributes rttr) {
      if(refservice.modify(refIndex) && service.refund(payIndex)) {
    	  rttr.addAttribute("result","success");
      }
      return "redirect:/pay/refundList";
   }
   
   @PreAuthorize("hasRole([ROLE_STUDENT])")
   @GetMapping("/myMoneyList")
   public void myMoneyList(@RequestParam("stuId") String stuId, Model model, Criteria cri) {
      model.addAttribute("list", service.getMyMoneyList(cri, stuId));
      model.addAttribute("refundList", service.getMyRefundList(cri, stuId));
   }
   
   @PreAuthorize("hasRole([ROLE_STUDENT])")
   @GetMapping("/payInfo")
   public void payInfo(@RequestParam("studyIndex") Long studyIndex, 
		   @RequestParam("studentId") String studentId , Model model) {
	   model.addAttribute("study", studyservice.get(studyIndex));
	   model.addAttribute("studentId", studentId);
   }
   
   @PreAuthorize("hasRole([ROLE_ADMIN])")
   @GetMapping("/paymentList")
   public void paymentList(Model model, Criteria cri) {
	   if(cri.getStart() != null && cri.getStart().length() == 0) {
		   cri.setStart(null);
		   cri.setEnd(null);
	   }
	   model.addAttribute("list", service.getPaymentList(cri));
	   model.addAttribute("pageMaker", new PageDTO(cri,service.getTotal(cri)));
   }
   
   @PreAuthorize("hasRole([ROLE_ADMIN])")
   @GetMapping("/beforeDeposit")
   public void beforeDeposit(Model model, Criteria cri) {
//	   List<LeaderVO> leaderlist = new ArrayList<LeaderVO>();
//	   List<PaymentVO> paylist = service.getBeforeDeposit(cri);
//	   model.addAttribute("paylist", paylist);
//	   
//	   for (PaymentVO pay : paylist) {
//		   leaderlist.add(leaderservice.get(pay.getLeaId()));
//	   }
//	   model.addAttribute("leaderlist", leaderlist);
	   model.addAttribute("list", service.getBeforeDeposit(cri));
   }
   
   @PreAuthorize("hasRole([ROLE_ADMIN])")
   @PostMapping("/deposit")
   public String deposit(@RequestParam("payIndex") Long payindex, RedirectAttributes rttr) {
	   log.info(payindex);
      if(service.deposit(payindex)) {
    	  rttr.addAttribute("result","success");
      }
      return "redirect:/pay/afterDeposit";
   }
   
   @PreAuthorize("hasRole([ROLE_ADMIN])")
   @GetMapping("/afterDeposit")
   public void afterDeposit(Model model, Criteria cri) {
	   model.addAttribute("list", service.getAfterDeposit(cri));
   }
   
   @PreAuthorize("hasRole([ROLE_ADMIN])")
   @GetMapping("/manageList")
	public void manageList(Model model, Criteria cri) {
	   if(cri.getStart() != null && cri.getStart().length() == 0) {
		   cri.setStart(null);
		   cri.setEnd(null);
	   }
	   model.addAttribute("list", service.getPaymentList(cri));
	   model.addAttribute("pageMaker", new PageDTO(cri,service.getTotal(cri)));
   }
   
   @PreAuthorize("hasRole([ROLE_STUDENT])")
   @PostMapping("/payment")
	public String register(PaymentVO payment,
			RedirectAttributes rttr) {
		
		service.pay(payment);
		
		rttr.addFlashAttribute("result", "success");
		return "redirect:/";
	}

}