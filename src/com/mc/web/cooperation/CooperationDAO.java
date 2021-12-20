package com.mc.web.cooperation;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CooperationDAO extends EgovAbstractMapper {

	public Map view(Map<String, String> params){
		return (Map) selectByPk("cooperation.view", params);
	}
	
	public List memberList(Map<String, String> params){
		return list("cooperation.memberList", params);
	}
	
	public int write(Map<String, String> params){
		return update("cooperation.write", params);
	}
	
	public int insertMember(Map<String, String> params){
		return update("cooperation.insertMember", params);
	}
	
	public int updateMember(Map<String, String> params){
		return update("cooperation.updateMember", params);
	}
	
	public int removeMember(Map<String, String> params){
		return delete("cooperation.removeMember", params);
	}
	
	public int modify(Map<String, String> params){
		return update("cooperation.modify", params);
	}
	
	public int statusUpdate(Map<String, String> params){
		return update("cooperation.statusUpdate", params);
	}
	
	public int del(Map<String, String> params){
		return update("cooperation.del", params);
	}
	
	public List cooperation_list(Map<String, String> params) {
		return list("cooperation.cooperation_list", params);
	}
	
	public Map cooperation_pagination(Map<String, String> params) {
		return (Map) selectByPk("cooperation.cooperation_pagination", params);
	}
	
	public List cooperation_other_list(Map<String, String> params) {
		return list("cooperation.cooperation_other_list", params);
	}
	
	public Map cooperation_other_pagination(Map<String, String> params) {
		return (Map) selectByPk("cooperation.cooperation_other_pagination", params);
	}
	
	public List repair_list(Map<String, String> params) {
		return list("cooperation.repair_list", params);
	}
	
	public Map repair_pagination(Map<String, String> params) {
		return (Map) selectByPk("cooperation.repair_pagination", params);
	}
	
	public Map repair_view(Map<String, String> params){
		return (Map) selectByPk("cooperation.repair_view", params);
	}

	public int updateUserCommission(Map params) {
		return update("cooperation.updateUserCommission", params);
	}
	
	public int updateComCommission(Map params) {
		return update("cooperation.updateComCommission", params);
	}
}
