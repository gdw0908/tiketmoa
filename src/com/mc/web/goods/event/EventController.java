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
 * @ClassName   : com.mc.web.goods.event.EventController.java
 * @Modification Information
 *
 * @author 오승택
 * @since 2015. 4. 6.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
@RequestMapping("/admin/goods/inventory/event_index.do")
public class EventController {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private EventService eventService;

	@ResponseBody
	@RequestMapping(params="mode=write")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		MCMap member = (MCMap) session.getAttribute("member");
		params.put("session_member_id", (String) member.get("member_id"));
		params.put("session_member_seq", (String) member.get("member_seq"));
		params.put("session_member_nm", (String) member.get("member_nm"));
		params.put("ip", request.getRemoteHost());
		return eventService.write(params);
	}
	
	@ResponseBody
	@RequestMapping(params="mode=delete")
	@Transactional(rollbackFor = { Exception.class })
	public Map delete(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		MCMap member = (MCMap) session.getAttribute("member");
		params.put("session_member_id", (String) member.get("member_id"));
		params.put("session_member_seq", (String) member.get("member_seq"));
		params.put("session_member_nm", (String) member.get("member_nm"));
		params.put("ip", request.getRemoteHost());
		return eventService.delete(params);
	}
	
	
	@ResponseBody
	@RequestMapping(params="mode=view")
	@Transactional(rollbackFor = { Exception.class })
	public Map view(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return eventService.view(params);
	}
	
	@ResponseBody
	@RequestMapping(params="mode=modify")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		MCMap member = (MCMap) session.getAttribute("member");
		params.put("session_member_id", (String) member.get("member_id"));
		params.put("session_member_seq", (String) member.get("member_seq"));
		params.put("session_member_nm", (String) member.get("member_nm"));
		params.put("ip", request.getRemoteHost());
		return eventService.modify(params);
	}
	
	@ResponseBody
	@RequestMapping(params="mode=list")
	@Transactional(rollbackFor = { Exception.class })
	public Map list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return eventService.list(params);
	}
	
	@ResponseBody
	@RequestMapping(params="mode=itemSearch")
	@Transactional(rollbackFor = { Exception.class })
	public Map itemSearch(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		params.put("cpage", jsonObject.get("cpage"));
		return eventService.itemSearch(params);
	}
	@ResponseBody
	@RequestMapping(params="mode=itemSelectList")
	@Transactional(rollbackFor = { Exception.class })
	public Map itemSelectList(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return eventService.itemSelectList(params);
	}
}