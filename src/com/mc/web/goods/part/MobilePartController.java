package com.mc.web.goods.part;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
/**
 * 
 *
 * @Description : 
 * @ClassName   : com.mc.web.goods.part.PartController.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2015. 3. 11.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class MobilePartController {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private PartService partService;
	
	@RequestMapping("/mobile/goods/list.do")
	public String list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", partService.list(params));
		return "mobile/goods/list";
	}
	
	@RequestMapping("/mobile/goods/view.do")
	public String view(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		Map data = partService.view(params);
		int stock_cnt = Integer.valueOf((String) ((Map)data.get("view")).get("stock_num"));
		if(stock_cnt <= 0){
			request.setAttribute("message", "이 상품의 재고가 더이상 없습니다.");
			return "message";
		}
		model.addAttribute("data", data);
		return "mobile/goods/view";
	}
	
	@RequestMapping("/mobile/popup/goods/other_list.do")
	public String other_list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", partService.other_list(params));
		return "mobile/goods/other_list";
	}
}
