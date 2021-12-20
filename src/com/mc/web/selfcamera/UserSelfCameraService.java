package com.mc.web.selfcamera;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.mc.web.Globals;
import com.mc.web.MCMap;
import com.mc.web.common.FileDAO;
import com.mc.web.common.FileUtil;

@Service
public class UserSelfCameraService {
	
	private Globals globals;
	
	@Autowired
	private SelfCameraDAO dao;
	
	@Value("#{config['upload.temp']}")
	private String TEMP_PATH;
	
	@Value("#{config['upload.board']}")
	private String UPLOAD_PATH;
	
	@Autowired
	private FileDAO fileDAO;
	
	@Autowired
	private FileUtil fileUtil;
	
	public String list(HttpServletRequest request, HttpSession session, Map params) throws Exception{
		MCMap member = (MCMap) session.getAttribute("member");
		String returnPage = "mobile/seller/selfcamera_list";
		if(member == null){
			request.setAttribute("message", globals.PERMISSION_DENIED);
			returnPage = "message";
		}else{
			if("3".equals(member.get("group_seq"))){//협력사 회원인 경우
				params.put("session_member_seq", (String) member.get("member_seq"));
				Map parent = (Map) dao.selectByPk("article.cooperation_parentSeq", params);
				params.put("com_seq", parent.get("parent_seq"));
				request.setAttribute("list", dao.getList(params));
				request.setAttribute("pagination", dao.getPagination(params));
			}else if("2".equals(member.get("group_seq"))){//일반회원은 권한 없음
				request.setAttribute("message", globals.PERMISSION_DENIED);
				returnPage = "message";
			}else{//관리자 or 자원관리회원
				request.setAttribute("list", dao.getList(params));
				request.setAttribute("pagination", dao.getPagination(params));
			}
		}
		return returnPage;
	}
	
	public String insertForm(HttpServletRequest request, HttpSession session, Map params) throws Exception{
		MCMap member = (MCMap) session.getAttribute("member");
		String returnPage = "mobile/seller/selfcamera_insert";
		if(member == null){
			request.setAttribute("message", globals.PERMISSION_DENIED);
			returnPage = "message";
		}else{
			if("3".equals(member.get("group_seq"))){//협력사 회원인 경우
				params.put("session_member_seq", (String) member.get("member_seq"));
				Map parent = (Map) dao.selectByPk("article.cooperation_parentSeq", params);
				request.setAttribute("com_seq",parent.get("parent_seq"));
				request.setAttribute("carmakerseq",dao.list("old_code.carmaker", null));
			}else if("2".equals(member.get("group_seq"))){//일반회원은 권한 없음
				request.setAttribute("message", globals.PERMISSION_DENIED);
				returnPage = "message";
			}else{//관리자 or 자원관리회원
				request.setAttribute("com_list",dao.list("seller.all_cooperation", null));
				request.setAttribute("carmakerseq",dao.list("old_code.carmaker", null));
			}
		}
		return returnPage;
	}

	public synchronized String insert(HttpServletRequest request, HttpSession session, Map params, List attachList) throws Exception {//시퀀스 중복방지를 위해 synchronized 사용
		MCMap member = (MCMap) session.getAttribute("member");
		Map rstMap = new HashMap();
		String returnPage = "redirect:selfcamera_list.do";
		if(member == null){
			request.setAttribute("message", globals.PERMISSION_DENIED);
			returnPage = "message";
		}else{
			params.put("session_member_seq", member.get("member_seq"));
			params.put("session_member_group_seq", member.get("group_seq"));		
			params.put("session_member_id", member.get("member_id"));
			params.put("session_member_nm", member.get("member_nm"));
			params.put("session_member_com_seq", member.get("com_seq"));
			params.put("ip", request.getRemoteHost());
			if("3".equals(member.get("group_seq"))){//협력사 회원인 경우
				Map parent = (Map) dao.selectByPk("article.cooperation_parentSeq", params);
				params.put("com_seq",parent.get("parent_seq"));
				setInsert(params,attachList,request);
			}else if("2".equals(member.get("group_seq"))){//일반회원은 권한 없음
				request.setAttribute("message", globals.PERMISSION_DENIED);
				returnPage = "message";
			}else{//관리자 or 자원관리회원
				setInsert(params,attachList,request);
			}
		}
		return returnPage;
	}
	
	public String modifyForm(HttpServletRequest request, HttpSession session, Map params) throws Exception{
		MCMap member = (MCMap) session.getAttribute("member");
		String returnPage = "mobile/seller/selfcamera_modify";
		if(member == null){
			request.setAttribute("message", globals.PERMISSION_DENIED);
			returnPage = "message";
		}else{
			params.put("session_member_seq", member.get("member_seq"));
			params.put("session_member_group_seq", member.get("group_seq"));		
			params.put("session_member_id", member.get("member_id"));
			params.put("session_member_nm", member.get("member_nm"));
			params.put("session_member_com_seq", member.get("com_seq"));
			if("3".equals(member.get("group_seq"))){//협력사 회원인 경우
				Map parent = (Map) dao.selectByPk("article.cooperation_parentSeq", params);
				request.setAttribute("com_seq",parent.get("parent_seq"));
				request.setAttribute("carmakerseq",dao.list("old_code.carmaker", null));
				request.setAttribute("data",getModify(params));
			}else if("2".equals(member.get("group_seq"))){//일반회원은 권한 없음
				request.setAttribute("message", globals.PERMISSION_DENIED);
				returnPage = "message";
			}else{//관리자 or 자원관리회원
				request.setAttribute("com_list",dao.list("seller.all_cooperation", null));
				request.setAttribute("carmakerseq",dao.list("old_code.carmaker", null));
				request.setAttribute("data",getModify(params));
			}
		}
		return returnPage;
	}
	
	public String modify(HttpServletRequest request, HttpSession session, Map params, List attachList) throws Exception{
		MCMap member = (MCMap) session.getAttribute("member");
		Map rstMap = new HashMap();
		String returnPage = "redirect:selfcamera_list.do";
		if(member == null){
			request.setAttribute("message", globals.PERMISSION_DENIED);
			returnPage = "message";
		}else{
			params.put("session_member_seq", member.get("member_seq"));
			params.put("session_member_group_seq", member.get("group_seq"));		
			params.put("session_member_id", member.get("member_id"));
			params.put("session_member_nm", member.get("member_nm"));
			params.put("session_member_com_seq", member.get("com_seq"));
			params.put("ip", request.getRemoteHost());
			if("3".equals(member.get("group_seq"))){//협력사 회원인 경우
				Map parent = (Map) dao.selectByPk("article.cooperation_parentSeq", params);
				params.put("com_seq",parent.get("parent_seq"));
				setModify(params,attachList,request);
			}else if("2".equals(member.get("group_seq"))){//일반회원은 권한 없음
				request.setAttribute("message", globals.PERMISSION_DENIED);
				returnPage = "message";
			}else{//관리자 or 자원관리회원
				setModify(params,attachList,request);
			}
		}
		return returnPage;
	}
	
	public String delete(HttpServletRequest request, HttpSession session, Map params) throws Exception {
		MCMap member = (MCMap) session.getAttribute("member");
		String returnPage = "redirect:selfcamera_list.do";
		if(member == null){
			request.setAttribute("message", globals.PERMISSION_DENIED);
			returnPage = "message";
		}else{
			params.put("session_member_seq", member.get("member_seq"));
			params.put("session_member_group_seq", member.get("group_seq"));		
			params.put("session_member_id", member.get("member_id"));
			params.put("session_member_nm", member.get("member_nm"));
			params.put("session_member_com_seq", member.get("com_seq"));
			if("3".equals(member.get("group_seq"))){//협력사 회원인 경우
				Map parent = (Map) dao.selectByPk("article.cooperation_parentSeq", params);
				Map m = getModify(params);
				Map view = (Map)m.get("view");
				if((parent.get("parent_seq")).equals(view.get("com_seq"))){
					dao.setDelete(params);
				}else{
					request.setAttribute("message", globals.PERMISSION_DENIED);
					returnPage = "message";
				}
			}else if("2".equals(member.get("group_seq"))){//일반회원은 권한 없음
				request.setAttribute("message", globals.PERMISSION_DENIED);
				returnPage = "message";
			}else{//관리자 or 자원관리회원
				dao.setDelete(params);
			}
		}
		return returnPage;
	}
	
	
	
	
	private Map setInsert(Map params, List fileList, HttpServletRequest request) throws Exception {
		Map rstMap = new HashMap();
		params.put("seq", dao.getNextval());
		dao.setInsert(params);
		if(fileList != null){//새파일 복사
			for (int i = 0; i < fileList.size(); i++) {
				String file = (String)fileList.get(i);
				String fileInfo[] = file.split("/");
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+fileInfo[0]+"/"+fileInfo[1]);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + fileInfo[2], path + File.separator + fileInfo[2],path);
				fileUtil.thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + (String) fileInfo[2], path + File.separator + fileInfo[2]+"_thumb" , 172, 118, false);
				Map m = new HashMap();
				m.put("uuid", fileInfo[2]);
				m.put("attach_nm", fileInfo[3]);
				m.put("reg_seq", params.get("session_member_seq"));
				m.put("reg_nm", params.get("session_member_nm"));
				m.put("yyyy", fileInfo[0]);
				m.put("mm", fileInfo[1]);
				m.put("order_seq", i+1);
				m.put("table_nm", "NSH_SELFCAMERA");
				m.put("table_seq", params.get("seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				fileDAO.insert(m);
			}
		}
		return rstMap;
	}
	
	private Map getModify(Map params) throws Exception{
		Map rstMap = new HashMap();
		Map view = dao.getView(params);
		//View Page
		rstMap.put("view", view);
		
		//File List
		params.put("table_nm", "NSH_SELFCAMERA");
		params.put("table_seq", params.get("seq"));
		rstMap.put("files", fileDAO.list(params));
		
		//Car Maker
		rstMap.put("carmakerseq", dao.list("old_code.carmaker",params));
		//Car Model
		rstMap.put("carmodel", dao.list("old_code.carmodel",view));
		//Car Grade
		rstMap.put("cargrade", dao.list("old_code.cargrade",view));
		
		return rstMap;
	}
	
	private Map setModify(Map params, List fileList, HttpServletRequest request) throws Exception{
		Map rstMap = new HashMap();
		Map oldfile = new HashMap();
		List<Map<String,String>> allFile = new ArrayList<Map<String,String>>();
		if(fileList != null){//새파일 복사
			for (int i = 0; i < fileList.size(); i++) {
				String file = (String)fileList.get(i);
				String fileInfo[] = file.split("/");
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+fileInfo[0]+"/"+fileInfo[1]);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + fileInfo[2], path + File.separator + fileInfo[2],path);
				fileUtil.thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + (String) fileInfo[2], path + File.separator + fileInfo[2]+"_thumb" , 172, 118, false);
				Map m = new HashMap();
				m.put("uuid", fileInfo[2]);
				m.put("attach_nm", fileInfo[3]);
				m.put("reg_seq", params.get("session_member_seq"));
				m.put("reg_nm", params.get("session_member_nm"));
				m.put("yyyy", fileInfo[0]);
				m.put("mm", fileInfo[1]);
				allFile.add(m);
			}
		}
		if(params.get("del_files") != null){//파일 삭제
			String delFile[] = ((String)params.get("del_files")).split(",");
			for (int i = 0; i < delFile.length; i++) {
				Map m = new HashMap();
				m.put("uuid", delFile[i]);
				dao.update("attach.delete", m);
			}
		}
		
		rstMap.put("table_nm", "NSH_SELFCAMERA");
		rstMap.put("table_seq", params.get("seq"));
		List oldFile = fileDAO.list(rstMap);
		fileDAO.delete_all(rstMap);//파일 전체 삭제
		if(oldFile != null){//기존 파일 받아오기
			for (int i = 0; i < oldFile.size(); i++) {
				Map m = (Map)oldFile.get(i);
				allFile.add(m);
			}
		}
		for (int i = 0; i < allFile.size(); i++) {
			Map m = (Map)allFile.get(i);
			m.put("order_seq", i+1);
			m.put("table_nm", "NSH_SELFCAMERA");
			m.put("table_seq", params.get("seq"));//mysql auto_increment 의 값을 가져온 값
			m.put("session_member_id", params.get("session_member_id"));
			m.put("session_member_seq", params.get("session_member_seq"));
			m.put("session_member_nm", params.get("session_member_nm"));
			fileDAO.insert(m);
		}
		rstMap.put("session_member_com_seq", params.get("session_member_com_seq"));
		dao.setModify(params);
		return rstMap;
	}
	
}
