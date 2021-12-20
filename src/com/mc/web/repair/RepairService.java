package com.mc.web.repair;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;

@Service
public class RepairService {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private RepairDAO repairDAO;
	
	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", repairDAO.view(params));
		return rstMap;
	}
	
	public Map write(Map params) throws Exception {
		Map rstMap = new HashMap();
		if(!StringUtil.isEmpty((String)params.get("zip1")) && !StringUtil.isEmpty((String)params.get("zip2"))){
			params.put("zip_cd", params.get("zip1")+"-"+params.get("zip2"));
		}
		if(!StringUtil.isEmpty((String)params.get("staff_tel1")) && !StringUtil.isEmpty((String)params.get("staff_tel2")) && !StringUtil.isEmpty((String)params.get("staff_tel3"))){
			params.put("staff_tel", params.get("staff_tel1")+"-"+params.get("staff_tel2")+"-"+params.get("staff_tel3"));
		}
		repairDAO.write(params);
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map modify(Map params) throws Exception {
		Map rstMap = new HashMap();
		if(!StringUtil.isEmpty((String)params.get("zip1")) && !StringUtil.isEmpty((String)params.get("zip2"))){
			params.put("zip_cd", params.get("zip1")+"-"+params.get("zip2"));
		}
		if(!StringUtil.isEmpty((String)params.get("staff_tel1")) && !StringUtil.isEmpty((String)params.get("staff_tel2")) && !StringUtil.isEmpty((String)params.get("staff_tel3"))){
			params.put("staff_tel", params.get("staff_tel1")+"-"+params.get("staff_tel2")+"-"+params.get("staff_tel3"));
		}
		repairDAO.modify(params);
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map del(Map params) throws Exception {
		Map rstMap = new HashMap();
		repairDAO.del(params);
		rstMap.put("rst", "1");
		return rstMap;
	}
	
}