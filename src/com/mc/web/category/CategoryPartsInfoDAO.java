package com.mc.web.category;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CategoryPartsInfoDAO extends EgovAbstractMapper {

	public Object getComInfoList(Map<String, String> params) {
		return list("category.getComInfoList", params);
	}
	
	public Object getcarInfoList(Map<String, String> params) {
		return list("category.getcarInfoList", params);
	}

	public Object getShopCodeList(Map<String, String> params) {
		return list("category.getShopCodeList", params);
	}
	
	public Object getCarPartsInfoList(Map<String, String> params) {
		return list("category.getCarPartsInfoList", params);
	}
	
	public Object getCarParts1DepsMenuList(Map<String, String> params) {
		return list("category.getCarParts1DepsMenuList", params);
	}
	
	public Object getPartInfoPageInfo(Map<String, String> params) {
		return selectByPk("category.getCarPartsInfoPage", params);
	}
	
	public Object getTableSeq(Map<String, String> params) {
		return selectByPk("category.getTableSeq", params);
	}

	public Object getCarPartsInfoViewList(Map<String, String> params) {
		return selectByPk("category.getCarPartsInfoViewList", params);
	}
	
	public Object getCarParts1DeptsViewList(Map<String, String> params) {
		return selectByPk("category.getCarParts1DeptsViewList", params);
	}
	
	public Object getCarPartsShopBunViewList(Map<String, String> params) {
		return selectByPk("category.getCarPartsShopBunViewList", params);
	}
	
	public Object getCarPartsShopViewList(Map<String, String> params) {
		return selectByPk("category.getCarPartsShopViewList", params);
	}
	
	public void updateCarPartsState(Map<String, String> params) {
		update("category.updateCarPartsState", params);
	}
	
	public void getUpdateCarModelName(Map<String, String> params) {
		update("category.getUpdateCarModelName", params);
	}
	
	public void getUpdateCarPartInfo(Map<String, String> params) {
		update("category.getUpdateCarPartInfo", params);
	}
	
	public void UpdateAttachData(Map<String, String> params) {
		update("category.UpdateAttachData", params);
	}

	public void InsertPartsData(Map<String, String> params) {
		insert("category.InsertPartsData", params);
	}
	
	public void InsertPartsDataQry(Map<String, String> params) {
		insert("category.InsertPartsDataQry", params);
	}
	
	public void InsertAttachData(Map<String, String> params) {
		insert("category.InsertAttachData", params);
	}
	
	
}
