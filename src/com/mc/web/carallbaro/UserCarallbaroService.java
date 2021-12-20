package com.mc.web.carallbaro;

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

import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.common.FileDAO;
import com.mc.web.common.FileUtil;

@Service
public class UserCarallbaroService {

	@Autowired
	private CarallbaroDAO dao;
	
	@Autowired
	private FileDAO fileDAO;
	
	@Autowired
	private FileUtil fileUtil;
	
	@Value("#{config['upload.temp']}")
	private String TEMP_PATH;
	
	@Value("#{config['upload.board']}")
	private String UPLOAD_PATH;
	
	public String main(HttpServletRequest request, HttpSession session, Map<String, String> params) throws Exception {
		return getPath(request)+"/main";
	}

	public String carallbaro_list(HttpServletRequest request, HttpSession session, Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		params.put("set_type","2");
		if(null == params.get("type_state") || "".equals(params.get("type_state"))){
			params.put("type_state","1");
		}
		if(null == params.get("cpage") || "".equals(params.get("cpage"))){
			params.put("cpage","1");
		}
		if(null == params.get("rows") || "".equals(params.get("rows"))){
			params.put("rows","10");
		}
		request.setAttribute("servlet_path", "carallbaro_list.do");
		request.setAttribute("list", dao.getList(params));
		request.setAttribute("page_info", dao.getPagination(params));
		request.setAttribute("params", params);
		return getPath(request)+"/carallbaro_list";
	}
	
	public String carallbaro_view(HttpServletRequest request, HttpSession session, Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		request.setAttribute("view", dao.getView(params));
		params.put("article_seq", params.get("seq"));
		request.setAttribute("params", params);
		List list = (List)dao.list("article.comment_list", params);
		List commentList = new ArrayList();
		for(int x=0; x < list.size(); x++){
			Map map = new HashMap();
			map = (Map)list.get(x);
			String conts = (String)map.get("conts");
			map.put("conts", StringUtil.clearXSS(conts,"br"));
			commentList.add(map);
		}
		request.setAttribute("comment",commentList);
		return getPath(request)+"/carallbaro_view";
	}
	
	public String quotation_list(HttpServletRequest request, HttpSession session, Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		params.put("type_state", "0");
		if(null == params.get("set_type") || "".equals(params.get("set_type"))){
			params.put("set_type","0,1");
		}
		if(null == params.get("cpage") || "".equals(params.get("cpage"))){
			params.put("cpage","1");
		}
		if(null == params.get("rows") || "".equals(params.get("rows"))){
			params.put("rows","10");
		}
		if(!("Y".equals(params.get("myarticle")) && sessionInfo(session, request, params))){
			params.remove("myarticle");
		}
		request.setAttribute("servlet_path", "quotation_list.do");
		request.setAttribute("list", dao.getList(params));
		request.setAttribute("page_info", dao.getPagination(params));
		request.setAttribute("params", params);
		return getPath(request)+"/quotation_list";
	}
	
	public String quotation_view(HttpServletRequest request, HttpSession session, Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		request.setAttribute("view", dao.getView(params));
		params.put("table_nm", "NSH_CARALLBARO");
		params.put("table_seq", params.get("seq"));
		params.put("article_seq",params.get("seq"));
		request.setAttribute("files", fileDAO.list(params));
		request.setAttribute("comment", dao.list("article.comment_list_cooperation", params));
		request.setAttribute("params", params);
		return getPath(request)+"/quotation_view";
	}
	
	public String quotation_fastForm(HttpServletRequest request, HttpSession session, Map<String, String> params) throws Exception {
		params.put("set_type", "1");
		params.put("type_state", "0");
		if(sessionInfo(session, request, params)){
			params.put("member_yn", "Y");
		}else{
			params.put("member_yn", "N");
		}
		params.put("code_group_seq", "5");
		params.put("use_yn", "Y");
		List<MCMap> carmaker_list = dao.list("old_code.carmaker", params);
		List<MCMap> sido_list = dao.list("code.sido", params);
		List<MCMap> code = dao.list("code.codeList", params);
		
		request.setAttribute("carmaker", carmaker_list);
		request.setAttribute("sido_cd", sido_list);
		request.setAttribute("code", code);
		request.setAttribute("params", params);
		return getPath(request)+"/quotation_fastForm";
	}
	
	public String quotation_insertForm(HttpServletRequest request, HttpSession session, Map<String, String> params) throws Exception {
		params.put("set_type", "0");
		params.put("type_state", "0");
		if(sessionInfo(session, request, params)){
			params.put("member_yn", "Y");
		}else{
			params.put("member_yn", "N");
		}
		params.put("code_group_seq", "5");
		params.put("use_yn", "Y");
		List<MCMap> carmaker_list = dao.list("old_code.carmaker", params);
		List<MCMap> sido_list = dao.list("code.sido", params);
		List<MCMap> code = dao.list("code.codeList", params);
		
		request.setAttribute("carmaker", carmaker_list);
		request.setAttribute("sido_cd", sido_list);
		request.setAttribute("code", code);
		request.setAttribute("params", params);
		return getPath(request)+"/quotation_insertForm";
	}
	
	public String quotation_fast(HttpServletRequest request, HttpSession session, Map<String, String> params, List attachList) throws Exception {
		Map rstMap = new HashMap();
		params.put("seq", dao.getNextval());
		params.put("set_type", "1");
		params.put("type_state", "0");
		params.put("tel",params.get("charge_tel1")+"-"+params.get("charge_tel2")+"-"+params.get("charge_tel3"));
		if(!sessionInfo(session, request, params)){
			params.put("session_member_group_seq", "0");
			params.put("session_member_seq", "0");
			params.put("session_member_nm", params.get("member_nm"));
			params.put("member_yn", "N");
		}else{
			params.put("member_yn", "Y");
		}
		dao.setInsert(params);
		if(attachList != null){//새파일 복사
			for (int i = 0; i < attachList.size(); i++) {
				String file = (String)attachList.get(i);
				String fileInfo[] = file.split("/");
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+fileInfo[0]+"/"+fileInfo[1]);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + fileInfo[2], path + File.separator + fileInfo[2],path);
				fileUtil.compulsion_thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + (String) fileInfo[2], path + File.separator + fileInfo[2]+"_thumb" , 172, 118, false);
				Map m = new HashMap();
				m.put("uuid", fileInfo[2]);
				m.put("attach_nm", fileInfo[3]);
				m.put("reg_seq", params.get("session_member_seq"));
				m.put("reg_nm", params.get("session_member_nm"));
				m.put("yyyy", fileInfo[0]);
				m.put("mm", fileInfo[1]);
				m.put("order_seq", i+1);
				m.put("table_nm", "NSH_CARALLBARO");
				m.put("table_seq", params.get("seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				fileDAO.insert(m);
			}
		}
		rstMap.put("rst", "1");
		return "redirect:quotation_list.do"+getMenu(request);
	}
	
	public String quotation_insert(HttpServletRequest request, HttpSession session, Map<String, String> params, List attachList) throws Exception {
		Map rstMap = new HashMap();
		params.put("seq", dao.getNextval());
		params.put("set_type", "0");
		params.put("type_state", "0");
		params.put("tel",params.get("charge_tel1")+"-"+params.get("charge_tel2")+"-"+params.get("charge_tel3"));
		if(!sessionInfo(session, request, params)){
			params.put("session_member_group_seq", "0");
			params.put("session_member_seq", "0");
			params.put("session_member_nm", params.get("member_nm"));
			params.put("member_yn", "N");
		}else{
			params.put("member_yn", "Y");
		}
		dao.setInsert(params);
		if(attachList != null){//새파일 복사
			for (int i = 0; i < attachList.size(); i++) {
				String file = (String)attachList.get(i);
				String fileInfo[] = file.split("/");
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+fileInfo[0]+"/"+fileInfo[1]);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + fileInfo[2], path + File.separator + fileInfo[2],path);
				fileUtil.compulsion_thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + (String) fileInfo[2], path + File.separator + fileInfo[2]+"_thumb" , 172, 118, false);
				Map m = new HashMap();
				m.put("uuid", fileInfo[2]);
				m.put("attach_nm", fileInfo[3]);
				m.put("reg_seq", params.get("session_member_seq"));
				m.put("reg_nm", params.get("session_member_nm"));
				m.put("yyyy", fileInfo[0]);
				m.put("mm", fileInfo[1]);
				m.put("order_seq", i+1);
				m.put("table_nm", "NSH_CARALLBARO");
				m.put("table_seq", params.get("seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				fileDAO.insert(m);
			}
		}
		rstMap.put("rst", "1");
		return "redirect:quotation_list.do"+getMenu(request);
	}
	
	public String quotation_modifyForm(HttpServletRequest request, HttpSession session, Map<String, String> params) throws Exception {
		Map view = dao.getView(params);
		if("Y".equals(view.get("member_yn"))){//회원글 일 경우
			if(sessionInfo(session, request, params)){//로그인했을 경우
				if(params.get("session_member_nm").equals(view.get("reg_nm"))){
					return modifyForm(request, session, params, view);
				}else{
					request.setAttribute("message","권한이 없습니다.");
					return "message";
				}
			}else{
				request.setAttribute("message","권한이 없습니다.");
				return "message";
			}
		}else{//비회원 글일 경우
			if("".equals(params.get("pass")) || params.get("pass") == null){//비밀번호가 없을 경우
				request.setAttribute("servletPath", "quotation_modifyForm.do");
				request.setAttribute("params", params);
				return getPath(request)+"/Password"; 
			}else{
				if(params.get("pass").equals(view.get("password"))){//비밀번호가 같을 경우
					return modifyForm(request, session, params, view);
				}else{
					request.setAttribute("message","비밀번호가 일치하지 않습니다.");
					return "message";
				}
			}
		}
	}
	
	public String quotation_modify(HttpServletRequest request, HttpSession session, Map<String, String> params, List attachList) throws Exception {
		Map view = dao.getView(params);
		if("Y".equals(view.get("member_yn"))){//회원 글 일 경우
			if(sessionInfo(session, request, params)){//로그인했을 경우
				if(params.get("session_member_nm").equals(view.get("reg_nm"))){//이름이 일치할 경우
					return setModify(request, session, params, attachList);
				}else{
					request.setAttribute("message", "권한이 없습니다.");
					return "message";
				}
			}else{
				request.setAttribute("message", "로그인 후 사용하시기 바랍니다.");
				return "message";
			}
		}else{//비회원 글 일 경우
			if(view.get("password").equals(params.get("password"))){
				return setModify(request, session, params, attachList);
			}else{
				request.setAttribute("message", "비밀번호가 일치하지 않습니다.");
				return "message";
			}
		}
	}
	
	public String quotation_delete(HttpServletRequest request, HttpSession session, Map<String, String> params) throws Exception {
		Map view = dao.getView(params);
		if("Y".equals(view.get("member_yn"))){//회원글 일 경우
			if(sessionInfo(session, request, params)){//로그인했을 경우
				if(params.get("session_member_nm").equals(view.get("reg_nm"))){
					dao.setDelete(params);
					return "redirect:quotation_list.do"+getMenu(request);
				}else{
					request.setAttribute("message","권한이 없습니다.");
					return "message";
				}
			}else{
				request.setAttribute("message","권한이 없습니다.");
				return "message";
			}
		}else{//비회원 글일 경우
			if("".equals(params.get("pass")) || params.get("pass") == null){//비밀번호가 없을 경우
				request.setAttribute("servletPath", "quotation_delete.do");
				request.setAttribute("params", params);
				return getPath(request)+"/Password"; 
			}else{
				if(params.get("pass").equals(view.get("password"))){//비밀번호가 같을 경우
					dao.setDelete(params);
					return "redirect:quotation_list.do"+getMenu(request);
				}else{
					request.setAttribute("message","비밀번호가 일치하지 않습니다.");
					return "message";
				}
			}
		}
	}
	
	private String getPath(HttpServletRequest request){
		String folder = request.getServletPath();
		String[] folderName = folder.split("/");
		if(folderName[1].equals("mobile")){
			return "/mobile/mypage/carallbaro";
		}else if(folderName[1].equals("pop")){
			return "/pop/mypage/carallbaro";
		}else{
			return "/mypage/carallbaro";
		}
	}
	
	private String getMenu(HttpServletRequest request){
		String folder = request.getServletPath();
		String[] folderName = folder.split("/");
		if(folderName[1].equals("mobile")){
			return "?menu=menu2";
		}else{
			return "";
		}
	}
	
	private boolean sessionInfo(HttpSession session, HttpServletRequest request, Map params){
		boolean returnValue = false;
		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			params.put("session_member_group_seq", (String) member.get("group_seq"));
			params.put("session_member_seq", (String) member.get("member_seq"));
			params.put("session_member_nm", (String) member.get("member_nm"));
			returnValue = true;
		}
		params.put("ip", request.getRemoteHost());
		return returnValue;
	}
	
	private String modifyForm(HttpServletRequest request, HttpSession session, Map<String, String> params, Map<String, Object> view){
		params.put("code_group_seq", "5");
		params.put("use_yn", "Y");
		params.put("sido", (String)view.get("sido_cd"));
		params.put("table_nm", "NSH_CARALLBARO");
		params.put("table_seq", params.get("seq"));
		
		List<MCMap> carmaker_list = dao.list("old_code.carmaker", params);
		List<MCMap> sido_list = dao.list("code.sido", params);
		List<MCMap> sigungu_list = dao.list("code.sigungu", params);
		List<MCMap> code = dao.list("code.codeList", params);
		List<MCMap> file_list = fileDAO.list(params);
		
		request.setAttribute("files", file_list);
		request.setAttribute("carmaker", carmaker_list);
		request.setAttribute("sido_cd", sido_list);
		request.setAttribute("sigungu_cd", sigungu_list);
		request.setAttribute("code", code);
		request.setAttribute("view", view);
		request.setAttribute("params", params);
		if("0".equals(view.get("set_type"))){
			return getPath(request)+"/quotation_modifyForm";
		}else{
			return getPath(request)+"/quotation_fastModifyForm";
		}
	}
	
	private String setModify(HttpServletRequest request, HttpSession session, Map<String, String> params, List attachList) throws Exception {
		Map rstMap = new HashMap();
		Map oldfile = new HashMap();
		params.put("tel",params.get("charge_tel1")+"-"+params.get("charge_tel2")+"-"+params.get("charge_tel3"));
		dao.setModify(params);
		List<Map<String,String>> allFile = new ArrayList<Map<String,String>>();
		if(attachList != null){//새파일 복사
			for (int i = 0; i < attachList.size(); i++) {
				String file = (String)attachList.get(i);
				String fileInfo[] = file.split("/");
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+fileInfo[0]+"/"+fileInfo[1]);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + fileInfo[2], path + File.separator + fileInfo[2],path);
				fileUtil.compulsion_thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + (String) fileInfo[2], path + File.separator + fileInfo[2]+"_thumb" , 172, 118, false);
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
		
		rstMap.put("table_nm", "NSH_CARALLBARO");
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
			m.put("table_nm", "NSH_CARALLBARO");
			m.put("table_seq", params.get("seq"));//mysql auto_increment 의 값을 가져온 값
			m.put("session_member_id", params.get("session_member_id"));
			m.put("session_member_seq", params.get("session_member_seq"));
			m.put("session_member_nm", params.get("session_member_nm"));
			fileDAO.insert(m);
		}
		rstMap.put("session_member_com_seq",params.get("session_member_com_seq"));
		return "redirect:quotation_list.do"+getMenu(request);
	}

	public String openMap(HttpServletRequest request, HttpSession session, Map<String, String> params) {
		request.setAttribute("data", dao.selectByPk("cooperation.view", params));
		if(!params.containsKey("mobile")){
			return "pop/openmap";
		}else{
			return "pop/openmap_m";
		}
	}
	
}
