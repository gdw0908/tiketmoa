package com.mc.web.carallbaro;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mc.web.MCMap;
import com.mc.web.board.BoardDAO;
import com.mc.web.board.MypageService;
import com.mc.web.mms.MmsService;

@Controller
@RequestMapping({"/{path}/mypage/comment/index.do"})
public class UserCarallbaroCommentController {
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private CarallbaroDAO dao;
	
	@Autowired
	private MmsService mmsService;
	
	@Autowired
	private UserCarallbaroCommentService service;
	
	@ResponseBody
	@RequestMapping(params="mode=commentInsert")
	@Transactional(rollbackFor = { Exception.class })
	public Map commentWrite(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			if("Y".equals(member.get("carall"))){
				params.put("session_member_group_seq", (String) member.get("group_seq"));
				params.put("session_member_seq", (String) member.get("member_seq"));
				params.put("session_member_nm", (String) member.get("member_nm"));
				params.put("reg_id", (String) member.get("member_id"));
				params.put("ip", request.getRemoteHost());
				params.put("servletPath", request.getServletPath());
	
				
				Map view = new HashMap();
				view.put("seq", params.get("article_seq"));
				view = dao.getView(view);
				if(view != null){
					Map mms = new HashMap();
					mms.put("tran_msg", "카올바로에 요청하신 견적에 대한 답글이 등록되었습니다 - 파츠모아");
					mms.put("tran_phone", view.get("tel"));
					mms.put("tran_callback", "1544-6444");
					mmsService.write(mms);
				}
				return service.commentWrite(params);
			}else{
				Map rstMap = new HashMap();
				rstMap.put("boolean", "false");
				return rstMap;
			}
		}else{
			params.put("session_member_group_seq", "99");
			params.put("session_member_seq", "0");
			params.put("session_member_nm", params.get("member_nm"));
			params.put("reg_id", "unknown");
			params.put("ip", request.getRemoteHost());
			params.put("servletPath", request.getServletPath());
			return service.commentWrite(params);
			
			//rstMap.put("boolean", "false");
			//return rstMap;
		}
	}
	
	@ResponseBody
	@RequestMapping(params="mode=commentReply")
	@Transactional(rollbackFor = { Exception.class })
	public Map commentReply(HttpServletRequest request, HttpSession session, @PathVariable("path") String path, @RequestParam Map<String, String> params) throws Exception{
		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			if("Y".equals(member.get("carall"))){
				params.put("session_member_group_seq", (String) member.get("group_seq"));
				params.put("session_member_seq", (String) member.get("member_seq"));
				params.put("session_member_nm", (String) member.get("member_nm"));
				params.put("reg_id", (String) member.get("member_id"));
				params.put("ip", request.getRemoteHost());
				params.put("servletPath", request.getServletPath());
				return service.commentReply(params);
			}else{
				Map rstMap = new HashMap();
				rstMap.put("boolean", "false");
				return rstMap;
			}
		}else{
			params.put("session_member_group_seq", "99");
			params.put("session_member_seq", "0");
			params.put("session_member_nm", params.get("member_nm"));
			params.put("reg_id", "unknown");
			params.put("ip", request.getRemoteHost());
			params.put("servletPath", request.getServletPath());
			return service.commentReply(params);
		}
	}
	
	@ResponseBody
	@RequestMapping(params="mode=commentDel")
	@Transactional(rollbackFor = { Exception.class })
	public Map commentDel(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			if("Y".equals(member.get("carall"))){
				params.put("session_member_group_seq", (String) member.get("group_seq"));
				params.put("session_member_seq", (String) member.get("member_seq"));
				params.put("session_member_nm", (String) member.get("member_nm"));
				params.put("reg_id", (String) member.get("member_id"));
				params.put("ip", request.getRemoteHost());
				params.put("servletPath", request.getServletPath());
				return service.commentDel(params);
			}else{
				Map rstMap = new HashMap();
				rstMap.put("rst", "1");
				rstMap.put("boolean", "false");
				return rstMap;
			}
		}else{
			Map rstMap = new HashMap();
			rstMap.put("rst", "1");
			rstMap.put("boolean", "false");
			return rstMap;
		}
	}
	
	@ResponseBody
	@RequestMapping(params="mode=commentReplyUpdate")
	@Transactional(rollbackFor = { Exception.class })
	public Map commentReplyUpdate(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			if("Y".equals(member.get("carall"))){
				params.put("session_member_group_seq", (String) member.get("group_seq"));
				params.put("session_member_seq", (String) member.get("member_seq"));
				params.put("session_member_nm", (String) member.get("member_nm"));
				params.put("reg_id", (String) member.get("member_id"));
				params.put("ip", request.getRemoteHost());
				params.put("servletPath", request.getServletPath());
				return service.commentReplyUpdate(params);
			}else{
				Map rstMap = new HashMap();
				rstMap.put("rst", "1");
				rstMap.put("boolean", "false");
				return rstMap;
			}
		}else{
			params.put("session_member_group_seq", "99");
			params.put("session_member_seq", "0");
			params.put("session_member_nm", params.get("member_nm"));
			params.put("reg_id", "unknown");
			params.put("ip", request.getRemoteHost());
			params.put("servletPath", request.getServletPath());
			return service.commentReplyUpdate(params);
			/*Map rstMap = new HashMap();
			rstMap.put("rst", "1");
			rstMap.put("boolean", "false");
			return rstMap;*/
		}
	}
}
