package com.mc.web.goods.event;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mc.web.MCMap;
/**
 *
 * @Description : 
 * @ClassName   : com.mc.web.goods.event.UserEventController.java
 * @Modification Information
 *
 * @author 오승택
 * @since 2015. 4. 6.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class UserEventController {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private EventService eventService;
	
	@RequestMapping("/event.do")
	@Transactional(rollbackFor = { Exception.class })
	public String userView(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		request.setAttribute("event", eventService.userView(params));
 		return "/event";
	}
	
	@RequestMapping("/event_part.do")
	@Transactional(rollbackFor = { Exception.class })
	public String userItem(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		request.setAttribute("event", eventService.userItem(params));
 		return "/event_part";
	}
}