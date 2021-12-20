package com.mc.web.selfcamera;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import com.mc.web.MCMap;

@Repository
public class SelfCameraDAO extends EgovAbstractMapper {

	public List<MCMap> getList(Map params) throws Exception {
		return list("selfcamera.list", params);
	}
	
	public MCMap getPagination(Map<String, String> params){
		return (MCMap) selectByPk("selfcamera.pagination", params);
	}
	
	public MCMap getView(Map params) throws Exception {
		return (MCMap)selectByPk("selfcamera.view", params);
	}
	
	public int setInsert(Map params) throws Exception {
		return insert("selfcamera.insert", params);
	}
	
	public int setModify(Map params) throws Exception {
		return update("selfcamera.update", params);
	}
	
	public int setDelete(Map params) throws Exception {
		return update("selfcamera.delete", params);
	}
	
	public String getNextval() {
		return selectByPk("article.nextval",null).toString();
	}
	
}