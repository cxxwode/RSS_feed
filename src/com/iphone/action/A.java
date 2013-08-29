package com.iphone.action;

import java.util.List;

import com.iphone.model.RssFeed;

public class  A {
	private String page;
	private String total;
	private String records;
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getRecords() {
		return records;
	}
	public void setRecords(String records) {
		this.records = records;
	}
	private List<RssFeed> rows;

	public List<RssFeed> getRows() {
		return rows;
	}
	public void setRows(List<RssFeed> rows) {
		this.rows = rows;
	}
	
}
