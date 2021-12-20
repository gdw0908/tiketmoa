package com.mc.web.selfcamera;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserSelfCameraController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UserSelfCameraService service;
	
	@RequestMapping(value="/mobile/seller/selfcamera_list.do")
	public String list(HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		return service.list(request, session, params);
	}
	
	@RequestMapping(value="/mobile/seller/selfcamera_insert.do", method=RequestMethod.GET )
	public String insertForm(HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		return service.insertForm(request, session, params);
	}
	
	@RequestMapping(value="/mobile/seller/selfcamera_insert.do", method=RequestMethod.POST )
	@Transactional(rollbackFor = { Exception.class })
	public String insert(HttpServletRequest request, HttpSession session, @RequestParam Map params, @RequestParam(value = "new_files", required = false) List attachList) throws Exception{
		return service.insert(request, session, params, attachList);
	}
	
	@RequestMapping(value="/mobile/seller/selfcamera_modify.do", method=RequestMethod.GET )
	public String modifyForm(HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		return service.modifyForm(request, session, params);
	}
	
	@RequestMapping(value="/mobile/seller/selfcamera_modify.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public String modify(HttpServletRequest request, HttpSession session, @RequestParam Map params, @RequestParam(value = "new_files", required = false) List attachList) throws Exception{
		return service.modify(request, session, params, attachList);
	}
	
	@RequestMapping(value="/mobile/seller/selfcamera_delete.do")
	@Transactional(rollbackFor = { Exception.class })
	public String insert(HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		return service.delete(request, session, params);
	}
}
