package com.iphone.model;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.codehaus.jackson.map.ext.JodaSerializers.DateTimeSerializer;
public class FeedNews {
	
	private int id;
	private int feedId;
	private String newsTitle;
	private String newsAuthor;
	private Date newsPublishedDate;
	private String readOrNot;
	private int favorite;
	private String newsUrl;
	
	public String getNewsUrl() {
		return newsUrl;
	}
	public void setNewsUrl(String newsUrl) {
		this.newsUrl = newsUrl;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getFeedId() {
		return feedId;
	}
	public void setFeedId(int feedId) {
		this.feedId = feedId;
	}

	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	public String getNewsAuthor() {
		return newsAuthor;
	}
	public void setNewsAuthor(String newsAuthor) {
		this.newsAuthor = newsAuthor;
	}
	public Date getNewsPublishedDate() {
		return newsPublishedDate;
	}
	public void setNewsPublishedDate(Date date) {
		this.newsPublishedDate = date;
	}
	public String getReadOrNot() {
		return readOrNot;
	}
	public void setReadOrNot(String readOrNot) {
		this.readOrNot = readOrNot;
	}
	public int getFavorite() {
		return favorite;
	}
	public void setFavorite(int favorite) {
		this.favorite = favorite;
	}
	
}
