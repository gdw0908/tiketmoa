package com.mc.web.selfcamera;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.mc.web.common.FileDAO;
import com.mc.web.common.FileUtil;

@Service
public class AdminSelfCameraService {
	
	Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private SelfCameraDAO dao;
	
	@Autowired
	private FileDAO fileDAO;
	
	@Autowired
	private FileUtil fileUtil;
	
	@Value("#{config['upload.temp']}")
	private String TEMP_PATH;
	
	@Value("#{config['upload.board']}")
	private String UPLOAD_PATH;
	
	
	public Map getList(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list",dao.getList(params));
		rstMap.put("pagination",dao.getPagination(params));
		return rstMap;
	}
	
	public Map getView(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", dao.getView(params));
		params.put("table_nm", "NSH_SELFCAMERA");
		params.put("table_seq", params.get("seq"));
		rstMap.put("files", fileDAO.list(params));
		return rstMap;
	}
	
	public synchronized Map setInsert(HttpServletRequest request, Map params) throws Exception {//시퀀스 중복방지를 위해 synchronized 사용
		Map rstMap = new HashMap();
		params.put("seq", dao.getNextval());
		params.put("parent_seq", "0");
		List list = (List) params.get("files");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("table_nm", "NSH_SELFCAMERA");
				m.put("table_seq", params.get("seq"));
				m.put("session_member_id", params.get("session_member_group_seq"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", params.get("ip"));
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+m.get("yyyy")+"/"+m.get("mm"));
				fileDAO.insert(m);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
			}
		}
		rstMap.put("rst", dao.setInsert(params));
		return rstMap;
	}
	
	public Map setModify(HttpServletRequest request, Map params) throws Exception {
		Map rstMap = new HashMap();
		dao.setModify(params);
		params.put("table_seq", params.get("seq"));
		params.put("table_nm", "NSH_SELFCAMERA");
		fileDAO.delete_all(params);
		List list = (List) params.get("files");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("table_nm", "NSH_SELFCAMERA");
				m.put("table_seq", params.get("seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", params.get("ip"));
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH + File.separator + m.get("yyyy") + File.separator + m.get("mm"));
				fileDAO.insert(m);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
			}
		}
		
		list = (List) params.get("removeFiles");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				fileUtil.delete(request.getSession().getServletContext().getRealPath(UPLOAD_PATH) + File.separator + m.get("yyyy") + File.separator + m.get("mm") + File.separator + m.get("uuid"));
			}
		}
		
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map setDelete(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.setDelete(params));
		return rstMap;
	}
}
