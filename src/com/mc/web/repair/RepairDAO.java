package com.mc.web.repair;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class RepairDAO extends EgovAbstractMapper {
	
	public Map view(Map<String, String> params){
		return (Map) selectByPk("repair.view", params);
	}
	
	public int write(Map<String, String> params){
		return update("repair.write", params);
	}
	
	public int modify(Map<String, String> params){
		return update("repair.modify", params);
	}
	
	public int del(Map<String, String> params){
		return update("repair.del", params);
	}
}
