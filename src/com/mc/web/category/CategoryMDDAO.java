package com.mc.web.category;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CategoryMDDAO extends EgovAbstractMapper {

	public Object getDeps1List(Map<String, String> params) {
		return list("category.getDeps1List", params);
	}
	
	public Object getServiceList(Map<String, String> params) {
		return list("category.getServiceList", params);
	}
	
	public void deleteService(Map<String, String> params) {
		update("category.deleteService", params);
	}
	
	public void insertService(Map<String, String> params) {
		update("category.insertService", params);
	}
	
	public Object CheckRegCount(Map<String, String> params) {
		return selectByPk("category.CheckRegCount", params);
	}

}
