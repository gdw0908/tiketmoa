package com.mc.web.category;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class MenuTreeDAO extends EgovAbstractMapper {

	public Object getList(Map<String, String> params) {
		return list("category.menuTreeList", params);
	}

	public Object getPageInfo(Map<String, String> params) {
		return selectByPk("article.page_info", params);
	}
	
	public Object getCouncilList(Map<String, String> params) {
		return list("article.council_list", params);
	}

	public Object getCouncilPageInfo(Map<String, String> params) {
		return selectByPk("article.council_page_info", params);
	}

	public void insert(Map<String, String> params) {
		insert("article.insert", params);
	}
	
	public void updateParentSeq(Map<String, String> params) {
		insert("article.updateParentSeq", params);
	}

	public void remove(String article_seq) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("article_seq", article_seq);
		MCMap article = (MCMap)selectByPk("article.article", params);
		String reply_depth = (String)article.get("reply_depth");
		String parent_seq = (String)article.get("parent_seq");
		if(reply_depth.equals("0") && parent_seq.endsWith("0") == false)
			update("article.removeAll", article);
		else{	//답변
			update("article.remove", params);
			params.put("article_seq", parent_seq);
			getSqlSession().update("article.update_reply_count_for_remove",params);
			int reply_cnt = getSqlSession().selectOne("article.reply_cnt", params);
			if(reply_cnt == 0){
				params.put("state", "0");
				update("article.update_state", params);
			}	
		}
	}
	
	public Object getArticle(Map<String, String> params) {
		return selectByPk("article.article", params);
	}

	public void update(Map<String, String> params) {
		insert("article.update", params);
	}

	public void updateReplyOrder(Map<String, String> params) {
		update("article.update_reply_order", params);
	}
	
	public void updateState(Map<String, String> params) {
		update("article.update_state", params);
	}
	

	public void updateViewCount(Map<String, String> params) {
		update("article.update_view_count", params);
	}
	
	public void updateRecommendCount(Map<String, String> params) {
		update("article.update_recommend_count", params);
	}

	public void updateReplyCount(Map<String, String> params) {
		update("article.update_reply_count", params);
	}
	public Object getReplyList(Map<String, String> params) {
		return list("article.reply_list", params);
	}
	
	public Object getAlist(Map<String, String> params) {
		return list("article.alist", params);
	}
}
