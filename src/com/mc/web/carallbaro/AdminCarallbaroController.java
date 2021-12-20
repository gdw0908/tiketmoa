package com.mc.web.carallbaro;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mc.web.MCMap;


@Controller
public class AdminCarallbaroController {

	@Autowired
	private AdminCarallbaroService service;
	
	@ResponseBody
	@RequestMapping(value="/admin/system/carallbaro/carallbaro_list.do")
	public Map list(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.list(params,session); 
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/system/carallbaro/carallbaro_view.do")
	public Map view(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		service.sessionInfo(session, request, params);
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/system/carallbaro/carallbaro_modify.do")
	@Transactional(rollbackFor={Exception.class})
	public Map modify(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		if(!service.sessionInfo(session, request, params)){
			return null;
		}else{
			return service.modify(params,request);
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/system/carallbaro/carallbaro_insert.do")
	@Transactional(rollbackFor={Exception.class})
	public Map insert(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		if(!service.sessionInfo(session, request, params)){
			return null;
		}else{
			return service.insert(params,request);
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/system/carallbaro/carallbaro_delete.do")
	@Transactional(rollbackFor={Exception.class})
	public Map delete(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		if(!service.sessionInfo(session, request, params)){
			return null;
		}else{
			return service.delete(params,request);
		}
	}
	
}
