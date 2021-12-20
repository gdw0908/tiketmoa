package com.mc.web.category;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CategoryCarModelNameDAO extends EgovAbstractMapper {

	public Object getComInfoList(Map<String, String> params) {
		return list("category.getComInfoList", params);
	}
	
	public Object getcarInfoList(Map<String, String> params) {
		return list("category.getcarInfoList", params);
	}
	
	public Object getCarModelNameList(Map<String, String> params) {
		return list("category.getCarModelNameList", params);
	}

	public Object getPageInfo(Map<String, String> params) {
		return selectByPk("category.getcarModelNamePageinfo", params);
	}
	
	public Object getViewList(Map<String, String> params) {
		return selectByPk("category.getcarModelNameViewList", params);
	}
	
	public void updateCarModelNameState(Map<String, String> params) {
		update("category.updateCarModelNameState", params);
	}
	
	public void getUpdateCarModelName(Map<String, String> params) {
		update("category.getUpdateCarModelName", params);
	}
	
	public Object getCarModelNameLastestIndex(Map<String, String> params) {
		return selectByPk("category.getCarModelNameLastestIndex", params);
	}
	
	public void CarModelNameInsert(Map<String, String> params) {
		insert("category.CarModelNameInsert", params);
	}
	
	public void CarModelNameInsertQry(Map<String, String> params) {
		insert("category.CarModelNameInsertQry", params);
	}
	
	
}
