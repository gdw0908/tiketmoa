package com.mc.web.m_carallbaro;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.transaction.xa.processor.XARequest.RequestType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ApplicationUserCarallbaorController {
	
	@Autowired
	private ApplicationUserCarallbaroService service;
	
	@RequestMapping("/m/mypage/carallbaro/index.do")
	public String carallbaro_main(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.main(request,session,params);	
	}
	
	@RequestMapping("/m/mypage/carallbaro/carallbaro_list.do")
	public String carallbaro_list(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.carallbaro_list(request,session,params);	
	}
	
	@RequestMapping("/m/mypage/carallbaro/carallbaro_view.do")
	public String carallbaro_view(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.carallbaro_view(request,session,params);	
	}
	
	@RequestMapping("/m/mypage/carallbaro/quotation_list.do")
	public String quotation_list(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.quotation_list(request,session,params);	
	}
	
	@RequestMapping("/m/mypage/carallbaro/quotation_view.do")
	public String quotation_view(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.quotation_view(request,session,params);	
	}
	
	@RequestMapping("/m/mypage/carallbaro/quotation_fastForm.do")
	public String carallbaro_fastForm(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.quotation_fastForm(request,session,params);	
	}
	
	@RequestMapping("/m/mypage/carallbaro/quotation_insertForm.do")
	public String carallbaro_insertForm(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.quotation_insertForm(request,session,params);	
	}
	
	@RequestMapping("/m/mypage/carallbaro/quotation_modifyForm.do")
	public String carallbaro_modifyForm(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.quotation_modifyForm(request,session,params);	
	}
	
	@RequestMapping("/m/mypage/carallbaro/quotation_modify.do")
	public String carallbaro_modify(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params, @RequestParam(value = "new_files", required = false) List attachList) throws Exception{
		return service.quotation_modify(request,session,params,attachList);	
	}
	
	@RequestMapping(value="/m/mypage/carallbaro/quotation_fast.do", method=RequestMethod.POST)
	public String carallbaro_fast(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params, @RequestParam(value = "new_files", required = false) List attachList) throws Exception{
		return service.quotation_fast(request,session,params,attachList);	
	}
	
	@RequestMapping(value="/m/mypage/carallbaro/quotation_insert.do", method=RequestMethod.POST)
	public String carallbaro_insert(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params, @RequestParam(value = "new_files", required = false) List attachList) throws Exception{
		return service.quotation_insert(request,session,params,attachList);	
	}
	
	@RequestMapping("/m/mypage/carallbaro/quotation_delete.do")
	public String carallbaro_insert(HttpServletRequest request,HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.quotation_delete(request,session,params);	
	}
	
}
