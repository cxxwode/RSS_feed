package com.iphone.action;

import com.iphone.rssfeed.manager.FeedNewsService;
import com.iphone.rssfeed.util.RssFeedUtil;
import com.opensymphony.xwork2.ActionSupport;


public class UserAction extends ActionSupport{
	
	private String page;
	private String rows;
	 
	 public String execute() {
		 
		RssFeedUtil rssFeedUtil = new RssFeedUtil();
		FeedNewsService fns = rssFeedUtil.getFeedNewsService();
		// List<FeedNews> feedNews = fns.getFeedNewsByFeedId();
		int totalRecord = 80; // 总记录数(应根据数据库取得，在此只是模拟)
		int totalPage = totalRecord % Integer.parseInt(rows) == 0 ? totalRecord
				/ Integer.parseInt(rows) : totalRecord / Integer.parseInt(rows)
				+ 1; // 计算总页数
		try {
			int index = (Integer.parseInt(page) - 1) * Integer.parseInt(rows); // 开始记录数
			int pageSize = Integer.parseInt(rows);
			// 以下模拟构造JSON数据对象
			String json = "{total: " + totalPage + ", page: " + page
					+ ", records: " + totalRecord + ", rows: [";
			for (int i = index; i < pageSize + index && i < totalRecord; i++) {
				json += "{cell:['ID " + i + "','NAME " + i + "','PHONE " + i
						+ "']}";
				if (i != pageSize + index - 1 && i != totalRecord - 1) {
					json += ",";
				}
			}
			json += "]}";
			return json; // 将JSON数据返回页面
		} catch (Exception ex) {
			return "";
		}
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}
	 

}
