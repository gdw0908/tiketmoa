package com.mc.web.carallbaro;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.mc.web.MCMap;
import com.mc.web.common.FileDAO;
import com.mc.web.common.FileUtil;

@Service
public class AdminCarallbaroService {

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
	
	public Map list(Map params,HttpSession session) throws Exception {
		Map rstMap = new HashMap();
		MCMap member = (MCMap)session.getAttribute("member");
		if("1".equals(member.get("group_seq")) || "2".equals(params.get("set_type")) || "carbr1".equals(member.get("member_id"))){
			rstMap.put("list", dao.getList(params));
			rstMap.put("pagination", dao.getPagination(params));
		}else{
			params.put("com_seq", member.get("com_seq"));
			rstMap.put("list", dao.getList_carall(params));
			rstMap.put("pagination", dao.getPagination_carall(params));
		}
				
		return rstMap;
	}

	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", dao.getView(params));
		params.put("table_nm", "NSH_CARALLBARO");
		params.put("table_seq", params.get("seq"));
		rstMap.put("files", fileDAO.list(params));
		return rstMap;
	}

	public Map modify(Map params,HttpServletRequest request) throws Exception {
		Map rstMap = new HashMap();
		if(params.get("thumb") != null && !("").equals(params.get("thumb"))){
			String thumb = (String)params.get("thumb");
			String[] thumb_array = thumb.split("/");
			System.out.println(request.getSession().getServletContext().getRealPath(File.separator+thumb_array[1]+File.separator+thumb_array[2]));
			String filepath = request.getSession().getServletContext().getRealPath(File.separator+thumb_array[1]+File.separator+thumb_array[2])+File.separator + thumb_array[3];
			System.out.println(filepath);
			int resultInt = fileUtil.thumb(filepath, filepath+"_thumb" , 172, 118, false);
			if(resultInt == 1){
				params.put("thumb",params.get("thumb")+"_thumb");
			}
		}
		rstMap.put("rst",dao.setModify(params));
		
		params.put("table_seq", params.get("seq"));
		params.put("table_nm", "NSH_CARALLBARO");
		fileDAO.delete_all(params);
		List list = (List) params.get("files");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("table_nm", "NSH_CARALLBARO");
				m.put("table_seq", params.get("seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", params.get("ip"));
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH + File.separator + m.get("yyyy") + File.separator + m.get("mm"));
				fileDAO.insert(m);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
				fileUtil.compulsion_thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid")+"_thumb" , 172, 118, false);
			}
		}
		
		list = (List) params.get("removeFiles");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				fileUtil.delete(request.getSession().getServletContext().getRealPath(UPLOAD_PATH) + File.separator + m.get("yyyy") + File.separator + m.get("mm") + File.separator + m.get("uuid"));
			}
		}
		return rstMap;
	}
	
	public synchronized Map insert(Map params, HttpServletRequest request) throws Exception {
		Map rstMap = new HashMap();
		params.put("seq", dao.getNextval());
		rstMap.put("rst", dao.setInsert(params));
		List list = (List) params.get("files");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("table_nm", "NSH_CARALLBARO");
				m.put("table_seq", params.get("seq"));//mysql auto_increment 의 값을 가져온 값
				m.put("session_member_id", params.get("session_member_group_seq"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", params.get("ip"));
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+m.get("yyyy")+"/"+m.get("mm"));
				fileDAO.insert(m);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
				fileUtil.compulsion_thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid")+"_thumb" , 172, 118, false);
			}
		}
		if(params.get("thumb") != null && !("").equals(params.get("thumb"))){
			String thumb = (String)params.get("thumb");
			String[] thumb_array = thumb.split("/");
			System.out.println(request.getSession().getServletContext().getRealPath(File.separator+thumb_array[1]+File.separator+thumb_array[2]));
			String filepath = request.getSession().getServletContext().getRealPath(File.separator+thumb_array[1]+File.separator+thumb_array[2])+File.separator + thumb_array[3];
			System.out.println(filepath);
			int resultInt = fileUtil.thumb(filepath, filepath+"_thumb" , 172, 118, false);
			if(resultInt == 1){
				params.put("thumb",params.get("thumb")+"_thumb");
			}
		}
		return rstMap;
	}
	
	public Map delete(Map params, HttpServletRequest request) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.setDelete(params));
		return rstMap;
	}
	
	public boolean sessionInfo(HttpSession session, HttpServletRequest request, Map params){
		boolean returnValue = false;
		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			params.put("session_member_group_seq", (String) member.get("group_seq"));
			params.put("session_member_seq", (String) member.get("member_seq"));
			params.put("session_member_nm", (String) member.get("member_nm"));
			params.put("ip", request.getRemoteHost());
			returnValue = true;
		}
		return returnValue;
	}
}
