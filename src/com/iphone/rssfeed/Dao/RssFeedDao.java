package com.iphone.rssfeed.Dao;

import java.util.List;

import com.iphone.model.RssFeed;

public interface RssFeedDao {
	
	public void save(RssFeed rssFeed);
	public void del(RssFeed rssFeed);
	public RssFeed getRssFeedById(int feedId);
	public List<RssFeed> getAllRssFeed();
	public List<RssFeed> getRssFeedByURL(String url);
}
